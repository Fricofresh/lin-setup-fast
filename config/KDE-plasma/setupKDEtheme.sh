#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/doncsugar/willow-theme.git"
clone_dir="$HOME/.cache/willow-theme"
dest_dir="$HOME/.local/share/aurorae/themes/WillowDark"
color_scheme="BreezeDark"

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../shared_functions.sh"

require_command git
require_command kwriteconfig6
require_command plasma-apply-lookandfeel
require_command plasma-apply-colorscheme
require_command plasma-apply-cursortheme

kde_config="$(get_kde_config_dir)"

mkdir -p "$(dirname "$dest_dir")"
rm -rf "$clone_dir"

if git clone --depth 1 "$repo_url" "$clone_dir"; then
    echo "Cloned Willow theme to $clone_dir"
else
    echo "Error: failed to clone $repo_url" >&2
    exit 1
fi

if [[ -d "$clone_dir/plasma-style/WillowDark" ]]; then
    rm -rf "$dest_dir"
    mv "$clone_dir/plasma-style/WillowDark" "$dest_dir"
    echo "Installed WillowDark aurorae theme to $dest_dir"
else
    echo "Error: expected theme folder not found: $clone_dir/plasma-style/WillowDark" >&2
    rm -rf "$clone_dir"
    exit 1
fi

rm -rf "$clone_dir"

kwriteconfig6 --file "$kde_config/kwinrc" --group org.kde.kdecoration2 --key library "org.kde.kwin.aurorae"
kwriteconfig6 --file "$kde_config/kwinrc" --group org.kde.kdecoration2 --key theme "__aurorae__svg__WillowDark"

# Theme
kwriteconfig6 --file "$kde_config/kdeglobals" --group General --key name "Breeze Dark"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KDE --key ColorScheme "$color_scheme"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"
kwriteconfig6 --file "$kde_config/kdeglobals" --group KDE --key SingleClick "false"

plasma-apply-lookandfeel --apply org.kde.breezedark.desktop
plasma-apply-colorscheme "$color_scheme"

# Mouse
kwriteconfig6 --file "$kde_config/kcminputrc" --group Mouse --key X11LibInputXAccelProfileFlat "true"

if plasma-apply-cursortheme --list-themes 2>/dev/null | grep -qF "[Posy_Cursor]"; then
    kwriteconfig6 --file "$kde_config/kcminputrc" --group Mouse --key cursorTheme "Posy_Cursor"
    plasma-apply-cursortheme Posy_Cursor
else
    print_status warning "Posy_Cursor is not installed; keeping the current cursor theme."
    print_status info "Install it from https://github.com/simtrami/posy-improved-cursor-linux"
fi
