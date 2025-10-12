#!/usr/bin/sh

kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 3 --group Configuration --group General --key icon "$BASEDIR/picture/TNSLogo.png"

# Taskbar
kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 5 --group Configuration --group General --key launchers "applications:org.rncbc.qpwgraph.desktop,applications:systemsettings.desktop,preferred://filemanager,applications:thunderbird.desktop,applications:terminator.desktop,preferred://browser,applications:youtube-music.desktop"

kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 7 --group General --key extraItems "org.kde.plasma.bluetooth,org.kde.plasma.networkmanagement,org.kde.kdeconnect,org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.brightness,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.battery,org.kde.plasma.volume knownItems=org.kde.plasma.bluetooth,org.kde.plasma.volume,org.kde.plasma.networkmanagement,org.kde.plasma.keyboardindicator,org.kde.kdeconnect,org.kde.plasma.vault,org.kde.plasma.keyboardlayout,org.kde.kscreen,org.kde.plasma.notifications,org.kde.plasma.cameraindicator,org.kde.plasma.brightness,org.kde.plasma.devicenotifier,org.kde.plasma.mediacontroller,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.battery showAllItems=true"

# Top Systemtray and Applets
#
