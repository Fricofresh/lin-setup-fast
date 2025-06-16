#!/usr/bin/sh

kreadconfig6 --file ~/.config/kglobalshortcutsrc --group services --group terminator.desktop --key _launch "Meta+T"
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group services --group systemsettings.desktop --key _launch "Meta+I\tTools"
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group services --group org.kde.plasma-systemmonitor.desktop --key _launch "Ctrl+Shift+Esc"
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group services --group org.kde.krunner.desktop --key _launch "Alt+Space"
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group services --group org.kde.krunner.desktop --key RunClipboard "none"

kreadconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key Overview "Meta+Tab,Meta+W,Toggle Overview"
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 2" "Meta+\",,Window to Desktop 2" 
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 3" "Meta+§,,Window to Desktop 3" 
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 4" "Meta+$,,Window to Desktop 4" 
kreadconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window to Desktop 5" "Meta+%,,Window to Desktop 5" 
