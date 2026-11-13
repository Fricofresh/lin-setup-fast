#!/usr/bin/env bash
# Written with AI
# ─────────────────────────────────────────────────────────────────────────────
# pw-chrome-monitor-links.sh
# Connects the pw-effects monitor ports to the virtual Microphone-Sink inputs,
# so desktop audio (e.g. Chrome) is available as a microphone.
# Run this after setupPipewireSink.sh has created the sink, for example from a
# ~/.config/autostart/ entry.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

MONITOR_FL="pw-effects:monitor_FL"
MONITOR_FR="pw-effects:monitor_FR"
MIC_FL="Microphone-Sink:input_FL"
MIC_FR="Microphone-Sink:input_FR"

if ! command -v pw-link >/dev/null 2>&1; then
    echo "ERROR: pw-link is not installed." >&2
    exit 1
fi

# Ports only exist while PipeWire is running with the configured nodes.
outputs="$(pw-link -o 2>/dev/null || true)"
inputs="$(pw-link -i 2>/dev/null || true)"

missing=()
grep -qxF "$MONITOR_FL" <<<"$outputs" || missing+=("$MONITOR_FL")
grep -qxF "$MONITOR_FR" <<<"$outputs" || missing+=("$MONITOR_FR")
grep -qxF "$MIC_FL" <<<"$inputs" || missing+=("$MIC_FL")
grep -qxF "$MIC_FR" <<<"$inputs" || missing+=("$MIC_FR")

if ((${#missing[@]})); then
    echo "ERROR: Cannot find the following port(s):" >&2
    printf '  - %s\n' "${missing[@]}" >&2
    echo "Run config/Audio/setupPipewireSink.sh first and make sure PipeWire is running." >&2
    exit 1
fi

link_exists() {
    local source="$1"
    local destination="$2"
    local line
    local section=""

    while IFS= read -r line; do
        if [[ "$line" != " "* ]]; then
            section="$line"
        elif [[ "$section" == "$source" && "$line" == *"|-> $destination"* ]]; then
            return 0
        fi
    done < <(pw-link -l 2>/dev/null)

    return 1
}

link_ports() {
    local source="$1"
    local destination="$2"

    if link_exists "$source" "$destination"; then
        echo "Already linked: $source -> $destination"
        return 0
    fi

    if ! pw-link "$source" "$destination"; then
        echo "ERROR: failed to link $source -> $destination" >&2
        return 1
    fi

    echo "Linked $source -> $destination"
}

link_ports "$MONITOR_FL" "$MIC_FL"
link_ports "$MONITOR_FR" "$MIC_FR"
