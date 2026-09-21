# TODO

- [x] copy TNS Logo see ./config/setupKDE.sh <br/>
~~Keybindings~~
- [x] krunnerrc
- [x] kwinrc -> org.kde.kdecoration2
- [x] Taskbar Items
- [x] System Tray Items and order
- [ ] plasma-org.kde.plasma.desktop.applet -> Containments -> 7
- [ ] Check changes in dotfiles
- [x] Change Locale
  - [x] All German representation only language is English
- [ ] Install Discover plugins and Themes - Maybe with https://git.symlinx.net/pkgit
  - [ ] [Posy's Cursor](https://github.com/simtrami/posy-improved-cursor-linux)
  - [ ] [Willow Dark](https://github.com/doncsugar/willow-theme/tree/main/aurorae-themes/WillowDark)
- [x] SDDM change time-date locale
- [x] change Plasma to dark mode
- [x] Setup camera
- [ ] Import Keybinding automatically
- [ ] Install Programms
  - [ ] VS Code Keybindings
  - [ ] Thunderbirid settings
    - [ ] Custom Time and Date
    - [ ] Weekday
  - [ ] rclone for Google Drive
    - [ ] add to default file explorer @remote
  - [ ] Nextcloud
    - [ ] add to default file explorer @remote
  - [ ] [YouTube Music](https://github.com/pear-devs/pear-desktop)
    - [ ] + Settings
- [ ] Split settings to seperate files for singular runs
- [ ] UI for configurations eg. [linutil](https://github.com/ChrisTitusTech/linutil)
  - [ ] Add
- [ ] Optional adding Steam
  - [ ] check for possible fixes with wrong partitions
- [ ] Search if [Howdy](https://github.com/boltgolt/howdy) is something that could be implemented


---

## Usage

Make the helper executable and run the task you want:

```bash
chmod +x setup.sh config/setupPrograms.sh config/*.sh config/KDE-plasma/*.sh
./setup.sh help
```