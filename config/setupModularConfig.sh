#!/usr/bin/env bash
set -euo pipefail

# Run selected setup modules from this directory instead of the whole task set.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$script_dir/shared_functions.sh"

usage() {
    cat <<EOF
Usage: $0 <module> [module...]

Run individual setup modules from $script_dir. The .sh suffix is optional.

Available modules:
$(find "$script_dir" -maxdepth 2 -name 'setup*.sh' ! -name 'setupModularConfig.sh' -printf '  %P\n' | sort)

Examples:
  $0 setupCamera
  $0 KDE-plasma/setupKDEtheme setupGlobalLocale
EOF
}

module_path() {
    local module="$1"

    if [[ "$module" == *.sh ]]; then
        echo "$script_dir/$module"
    else
        echo "$script_dir/$module.sh"
    fi
}

main() {
    if [[ $# -eq 0 ]]; then
        usage
        exit 1
    fi

    local failed=0
    local module
    local path

    for module in "$@"; do
        path="$(module_path "$module")"

        if [[ ! -f "$path" ]]; then
            print_status error "Module not found: $path"
            failed=1
            continue
        fi

        echo "Running $path"
        if bash "$path"; then
            print_status success "Completed: $module"
        else
            print_status error "Failed: $module"
            failed=1
        fi
    done

    return "$failed"
}

# Run main if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
