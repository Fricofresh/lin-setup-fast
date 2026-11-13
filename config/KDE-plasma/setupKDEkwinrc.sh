#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$script_dir/../shared_functions.sh"

require_command kwriteconfig6
kde_config="$(get_kde_config_dir)"

kwriteconfig6 --file "$kde_config/kwinrc" --group org.kde.kdecoration2 --key ButtonsOnLeft "M"
kwriteconfig6 --file "$kde_config/kwinrc" --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
kwriteconfig6 --file "$kde_config/kwinrc" --group org.kde.kdecoration2 --key CloseOnDoubleClickOnMenu "true"
kwriteconfig6 --file "$kde_config/kwinrc" --group org.kde.kdecoration2 --key library "org.kde.kwin.aurorae"
kwriteconfig6 --file "$kde_config/kwinrc" --group org.kde.kdecoration2 --key theme "__aurorae__svg__WillowDark"
