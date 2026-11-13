#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$script_dir/../shared_functions.sh"

require_command kwriteconfig6
kde_config="$(get_kde_config_dir)"

kwriteconfig6 --file "$kde_config/krunnerrc" --group General --key FreeFloating "true"
kwriteconfig6 --file "$kde_config/krunnerrc" --group Plugins --key browsertabsEnabled "false"
