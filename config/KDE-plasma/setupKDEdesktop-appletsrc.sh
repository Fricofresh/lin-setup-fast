#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$script_dir/../shared_functions.sh"

require_command kwriteconfig6

repo_root="$(dirname "$(dirname "$script_dir")")"
icons_dir="${XDG_DATA_HOME:-$HOME/.local/share}/icons"
icon_path="$icons_dir/TNSLogo.png"
kde_config="$(get_kde_config_dir)"
appletsrc="$kde_config/plasma-org.kde.plasma.desktop-appletsrc"

# Containment and applet ids are assigned by Plasma and differ between
# installations. Override them when the layout does not match the defaults.
panel_containment="${KDE_PANEL_CONTAINMENT:-2}"
icon_applet="${KDE_ICON_APPLET:-3}"
taskbar_applet="${KDE_TASKBAR_APPLET:-5}"
tray_containment="${KDE_TRAY_CONTAINMENT:-7}"

write_applet_setting() {
    local group_header="$1"
    shift

    # Only write existing groups; otherwise kwriteconfig6 creates orphaned
    # settings that never show up in the desktop.
    if [[ ! -f "$appletsrc" ]] || ! grep -qxF "$group_header" "$appletsrc"; then
        print_status warning "Skipping setting for missing group: $group_header"
        return 0
    fi

    kwriteconfig6 --file "$appletsrc" "$@"
}

# Install the logo outside the repository so the launcher icon keeps working
# when the repository is moved or removed.
mkdir -p "$icons_dir"
cp -f "$repo_root/picture/TNSLogo.png" "$icon_path"

write_applet_setting "[Containments][$panel_containment][Applets][$icon_applet][Configuration][General]" \
    --group Containments --group "$panel_containment" --group Applets --group "$icon_applet" --group Configuration --group General --key icon "$icon_path"

# Taskbar
write_applet_setting "[Containments][$panel_containment][Applets][$taskbar_applet][Configuration][General]" \
    --group Containments --group "$panel_containment" --group Applets --group "$taskbar_applet" --group Configuration --group General --key launchers "applications:org.rncbc.qpwgraph.desktop,applications:systemsettings.desktop,preferred://filemanager,applications:thunderbird.desktop,applications:terminator.desktop,preferred://browser,applications:youtube-music.desktop"

write_applet_setting "[Containments][$tray_containment][General]" \
    --group Containments --group "$tray_containment" --group General --key extraItems "org.kde.plasma.bluetooth,org.kde.plasma.networkmanagement,org.kde.kdeconnect,org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.brightness,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.battery,org.kde.plasma.volume"

write_applet_setting "[Containments][$tray_containment][General]" \
    --group Containments --group "$tray_containment" --group General --key knownItems "org.kde.plasma.bluetooth,org.kde.plasma.volume,org.kde.plasma.networkmanagement,org.kde.plasma.keyboardindicator,org.kde.kdeconnect,org.kde.plasma.vault,org.kde.plasma.keyboardlayout,org.kde.kscreen,org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.brightness,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.battery"

write_applet_setting "[Containments][$tray_containment][General]" \
    --group Containments --group "$tray_containment" --group General --key showAllItems "true"
