#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
config_dir="$script_dir/config"

# Shared libraries are sourced by the task scripts and must not be executed.
helper_scripts=("shared_functions.sh")
# Tasks that need their own arguments and are therefore not part of `all`.
argument_tasks=("setupPrograms.sh" "setupModularConfig.sh")

failed_tasks=()
running_all=0

run_script() {
    local script_path="$1"
    shift
    local base
    base="$(basename "$script_path")"

    if [[ ! -f "$script_path" ]]; then
        echo "WARNING: missing $script_path"
        return 0
    fi

    if [[ " ${helper_scripts[*]} " == *" $base "* ]]; then
        return 0
    fi

    if [[ $running_all -eq 1 && " ${argument_tasks[*]} " == *" $base "* ]]; then
        echo "Skipping $base (needs arguments; run it directly)"
        return 0
    fi

    echo
    echo "Running $script_path"
    if [[ -x "$script_path" ]]; then
        "$script_path" "$@"
    else
        bash "$script_path" "$@"
    fi
}

# Run every task in a directory. Failures are collected so that one broken task
# does not abort the whole run.
run_scripts_in_dir() {
    local dir="$1"
    local script_path
    for script_path in "$dir"/*.sh; do
        run_script "$script_path" || failed_tasks+=("$script_path")
    done
}

run_all() {
    local dir
    running_all=1
    run_scripts_in_dir "$config_dir"
    for dir in "$config_dir"/*/; do
        run_scripts_in_dir "${dir%/}"
    done
}

show_help() {
    cat <<EOF
Usage: $0 <command>

Commands:
  all           Run all configured setup tasks (except tasks needing arguments)
  kde           Run KDE/Plasma setup scripts
  audio         Run PipeWire audio setup scripts
  locale        Run global locale setup (needs root, uses sudo)
  camera        Run camera setup
  programs      Install packages from a list: $0 programs <url-or-path>
  alternatives  Run alternatives setup
  python        Run Python environment setup
  help          Show this help

Examples:
  $0 kde
  $0 programs https://example.com/packages.txt
EOF
}

case "${1-}" in
    all)
        run_all
        ;;
    kde)
        run_scripts_in_dir "$config_dir/KDE-plasma"
        ;;
    audio)
        run_scripts_in_dir "$config_dir/Audio"
        ;;
    locale)
        run_script "$config_dir/setupGlobalLocale.sh" || failed_tasks+=("$config_dir/setupGlobalLocale.sh")
        ;;
    camera)
        run_script "$config_dir/setupCamera.sh" || failed_tasks+=("$config_dir/setupCamera.sh")
        ;;
    programs)
        run_script "$config_dir/setupPrograms.sh" "${@:2}" || failed_tasks+=("$config_dir/setupPrograms.sh")
        ;;
    alternatives)
        run_script "$config_dir/setupAlternatives.sh" || failed_tasks+=("$config_dir/setupAlternatives.sh")
        ;;
    python)
        run_script "$config_dir/setupPython.sh" || failed_tasks+=("$config_dir/setupPython.sh")
        ;;
    help|-h|--help)
        show_help
        exit 0
        ;;
    *)
        show_help >&2
        exit 2
        ;;
esac

if [[ ${#failed_tasks[@]} -gt 0 ]]; then
    echo
    echo "Failed tasks (${#failed_tasks[@]}):"
    printf '  %s\n' "${failed_tasks[@]}"
    exit 1
fi
