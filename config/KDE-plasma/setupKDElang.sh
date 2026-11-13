#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$script_dir/../shared_functions.sh"

require_command kwriteconfig6
kde_config="$(get_kde_config_dir)"

# Setup language

kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LANG "en_US.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_ADDRESS "de_DE.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_MEASUREMENT "de_DE.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_MONETARY "de_DE.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_NAME "de_DE.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_NUMERIC "de_DE.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_PAPER "de_DE.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_TELEPHONE "de_DE.UTF-8"
kwriteconfig6 --file "$kde_config/plasma-localerc" --group Formats --key LC_TIME "de_DE.UTF-8"
