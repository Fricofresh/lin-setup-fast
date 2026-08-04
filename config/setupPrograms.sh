#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/shared_functions.sh"

usage() {
    cat <<EOF
Usage: $0 <url-or-path>

Download a newline-separated package list from a URL or read a local file, then install all packages using the detected package manager.

Examples:
  $0 https://example.com/packages.txt
  $0 /tmp/packages.txt
EOF
}

is_url() {
    local value="$1"
    [[ "$value" =~ ^https?:// ]]
}

download_package_list() {
    local url="$1"
    local dest="$2"

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget >/dev/null 2>&1; then
        wget -qO "$dest" "$url"
    else
        print_status error "Neither curl nor wget is installed. Install one to use URL input."
        exit 1
    fi
}

parse_packages() {
    local input_file="$1"
    local line

    mapfile -t package_lines < <(grep -E '^[[:space:]]*[^#[:space:]]' "$input_file" || true)

    declare -A seen
    packages=()

    for line in "${package_lines[@]}"; do
        line="${line%%#*}"
        line="${line//[$'\r\t']/ }"
        line="$(printf '%s' "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        [[ -z "$line" ]] && continue
        if [[ -n "${seen[$line]:-}" ]]; then
            continue
        fi
        seen[$line]=1
        packages+=("$line")
    done
}

main() {
    if [[ $# -ne 1 ]]; then
        usage
        exit 1
    fi

    local source_path="$1"
    local input_file

    if is_url "$source_path"; then
        input_file="$(mktemp)"
        trap 'rm -f "$input_file"' EXIT
        print_status info "Downloading package list from URL: $source_path"
        download_package_list "$source_path" "$input_file"
    else
        if [[ ! -f "$source_path" ]]; then
            print_status error "File not found: $source_path"
            exit 1
        fi
        input_file="$source_path"
    fi

    parse_packages "$input_file"

    if [[ ${#packages[@]} -eq 0 ]]; then
        print_status error "No valid packages found in input."
        exit 1
    fi

    print_status info "Detected package manager: $(detect_package_manager)"
    print_status info "Installing ${#packages[@]} package(s): ${packages[*]}"

    install_packages "${packages[@]}"
}

main "$@"
