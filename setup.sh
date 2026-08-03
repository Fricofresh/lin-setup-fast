#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
config_dir="$script_dir/config"

run_script() {
    local script_path="$1"
    if [[ -x "$script_path" ]]; then
        echo "Running $script_path"
        "$script_path"
    elif [[ -f "$script_path" ]]; then
        echo "Running $script_path"
        bash "$script_path"
    else
        echo "WARNING: missing $script_path"
    fi
}

run_scripts_in_dir() {
    local dir="$1"
    for script_path in "$dir"/*.sh; do
        run_script "$script_path"
    done
}

show_help() {
    cat <<EOF
Usage: $0 <command>

Commands:
  all           Run all configured setup tasks
  kde           Run KDE/Plasma setup scripts
  locale        Run global locale setup
  camera        Run camera setup
  programs      Run program install / config helper
  alternatives  Run alternatives setup
  python        Run Python environment setup
  help          Show this help
EOF
}

case "${1-}" in
    all)
        run_scripts_in_dir "$config_dir"
        run_scripts_in_dir "$config_dir/KDE-plasma"
        ;;
    kde)
        run_scripts_in_dir "$config_dir/KDE-plasma"
        ;;
    locale)
        run_script "$config_dir/setupGlobalLocale.sh"
        ;;
    camera)
        run_script "$config_dir/setupCamera.sh"
        ;;
    programs)
        run_script "$config_dir/setupPrograms.sh"
        ;;
    alternatives)
        run_script "$config_dir/setupAlternatives.sh"
        ;;
    python)
        run_script "$config_dir/setupPython.sh"
        ;;
    help|*)
        show_help
        ;;
esac