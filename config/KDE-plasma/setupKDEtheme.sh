#!/usr/bin/bash

willowThemePath="~/Documents/git/willow-theme"
git clone https://github.com/doncsugar/willow-theme.git "$willowThemePath"
mv "$willowThemePath/plasma-style/WillowDark/" /home/fricofresh/.local/share/aurorae/themes/WillowDark/
rm -r "$willowThemePath"


kwriteconfig6 --file ~/.config/kwinrc --group org.kde.kdecoration2 --key library "org.kde.kwin.aurorae"
kwriteconfig6 --file ~/.config/kwinrc --group org.kde.kdecoration2 --key theme "__aurorae__svg__WillowDark"


# Theme
kwriteconfig6 --file ~/.config/kdeglobals --group General --key name "Breeze Dark"
kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key ColorScheme "Breeze"
kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"
kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key SingleClick "false"

plasma-apply-lookandfeel --apply org.kde.breezedark.desktop

# Mouse
kwriteconfig6 --file ~/.config/kcminputrc --group Mouse --key cursorTheme "Posy_Cursor_Strokeless"

plasma-apply-cursortheme Posy_Cursor_Strokeless
