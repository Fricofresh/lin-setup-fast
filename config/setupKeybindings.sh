#!/usr/bin/env bash
set -euo pipefail

# Standalone entry point for applying the KDE shortcuts without running the
# whole KDE task. The shortcuts themselves live in KDE-plasma/.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$script_dir/shared_functions.sh"

main() {
    if ! is_kde_plasma; then
        print_status warning "This does not look like a KDE Plasma session; applying shortcuts anyway."
    fi

    local shortcuts_script="$script_dir/KDE-plasma/setupKDEshortcuts.sh"
    if [[ ! -f "$shortcuts_script" ]]; then
        print_status error "Missing shortcut script: $shortcuts_script"
        return 1
    fi

    if ! bash "$shortcuts_script"; then
        print_status error "Failed to apply the KDE shortcuts."
        return 1
    fi

    print_status success "KDE shortcuts applied."
}

# Run main if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
