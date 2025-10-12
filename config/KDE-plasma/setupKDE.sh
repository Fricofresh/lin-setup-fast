#!/usr/bin/sh

BASEDIR=$(realpath $(dirname "$0")"/..")

# Terminal
kwriteconfig6 --file ~/.config/kdeglobals --group General --key TerminalService "terminator.desktop"
kwriteconfig6 --file ~/.config/kdeglobals --group General --key TerminalApplication "terminator"

# Theme
kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 3 --group Configuration --group General --key icon "$BASEDIR/picture/TNSLogo.png"
kwriteconfig6 --file ~/.config/kdeglobals --group General --key name "Breeze Dark"
kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key ColorScheme "Breeze"
kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"
kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key SingleClick "false"
## Taskbar
kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 5 --group Configuration --group General --key launchers "applications:org.rncbc.qpwgraph.desktop,applications:systemsettings.desktop,preferred://filemanager,applications:thunderbird.desktop,applications:terminator.desktop,preferred://browser,applications:youtube-music.desktop"

## KFileDialog Settings
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Allow Expansion" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Automatically select filename extension" "true"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Breadcrumb Navigation" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Decoration position" "2"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "LocationCombo Completionmode" "5"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "PathCombo Completionmode" "5"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Show Bookmarks" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Show Full Path" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Show Inline Previews" "true"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Show Preview" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Show Speedbar" "true"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Show hidden files" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Sort by" "Name"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Sort directories first" "true"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Sort hidden files last" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Sort reversed" "false"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "Speedbar Width" "138"
kwriteconfig6 --file ~/.config/kdeglobals --group KFileDialog Settings --key "View Style" "DetailTree"

# Mouse
kwriteconfig6 --file ~/.config/kcminputrc --group Mouse --key X11LibInputXAccelProfileFlat "true"
kwriteconfig6 --file ~/.config/kcminputrc --group Mouse --key cursorTheme "Posy_Corsor_Stokeless"
