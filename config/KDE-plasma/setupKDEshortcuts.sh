#!/usr/bin/env bash

# Setup KDE keybindings using kwriteconfig6 commands

# Set up the keybinding for Terminator terminal 
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group services --group terminator.desktop --key _launch "Meta+T"

# Set up the keybinding for System Settings  
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group services --group systemsettings.desktop --key _launch "Meta+I\tTools"

# Set up keybindings for other applications
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group services --group org.kde.plasma-systemmonitor.desktop --key _launch "Ctrl+Shift+Esc"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group services --group org.kde.krunner.desktop --key _launch "Alt+Space"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group services --group org.kde.krunner.desktop --key RunClipboard "none"

# Set up KWin window management keybindings
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Left" "Meta+Ctrl+Left,Meta+Ctrl+Left,Switch One Desktop to the Left" 
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Right" "Meta+Ctrl+Right,Meta+Ctrl+Right,Switch One Desktop to the Right" 
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key Overview "Meta+Tab,Meta+W,Toggle Overview"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 2" "Meta+\",,Window to Desktop 2" 
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 3" "Meta+§,,Window to Desktop 3" 
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 4" "Meta+$,,Window to Desktop 4" 
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 5" "Meta+%,,Window to Desktop 5" 
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window Above Other Windows" "Meta+Ctrl+T,,Keep Window Above Others" 
