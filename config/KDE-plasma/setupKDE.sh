#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$script_dir/../shared_functions.sh"

require_command kwriteconfig6
kde_config="$(get_kde_config_dir)"

# Terminal
kwriteconfig6 --file "$kde_config/kdeglobals" --group General --key TerminalService "terminator.desktop"
kwriteconfig6 --file "$kde_config/kdeglobals" --group General --key TerminalApplication "terminator"

## KFileDialog Settings
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Allow Expansion" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Automatically select filename extension" "true"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Breadcrumb Navigation" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Decoration position" "2"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "LocationCombo Completionmode" "5"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "PathCombo Completionmode" "5"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Show Bookmarks" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Show Full Path" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Show Inline Previews" "true"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Show Preview" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Show Speedbar" "true"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Show hidden files" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Sort by" "Name"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Sort directories first" "true"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Sort hidden files last" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Sort reversed" "false"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "Speedbar Width" "138"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KFileDialog Settings --key "View Style" "DetailTree"
