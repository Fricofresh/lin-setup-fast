#!/usr/bin/env bash
set -euo pipefail

ScriptPath="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
icons_dir="${XDG_DATA_HOME:-$HOME/.local/share}/icons"
icon_path="$icons_dir/TNSLogo.png"

# Install the logo outside the repository so the launcher icon keeps working
# when the repository is moved or removed.
mkdir -p "$icons_dir"
cp -f "$ScriptPath/picture/TNSLogo.png" "$icon_path"

kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 3 --group Configuration --group General --key icon "$icon_path"

# Taskbar
kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 5 --group Configuration --group General --key launchers "applications:org.rncbc.qpwgraph.desktop,applications:systemsettings.desktop,preferred://filemanager,applications:thunderbird.desktop,applications:terminator.desktop,preferred://browser,applications:youtube-music.desktop"

kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 7 --group General --key extraItems "org.kde.plasma.bluetooth,org.kde.plasma.networkmanagement,org.kde.kdeconnect,org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.brightness,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.battery,org.kde.plasma.volume"
kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 7 --group General --key knownItems "org.kde.plasma.bluetooth,org.kde.plasma.volume,org.kde.plasma.networkmanagement,org.kde.plasma.keyboardindicator,org.kde.kdeconnect,org.kde.plasma.vault,org.kde.plasma.keyboardlayout,org.kde.kscreen,org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.brightness,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.battery"
kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 7 --group General --key showAllItems "true"
