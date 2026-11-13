# lin-setup-fast

Bash scripts to set up a fresh Linux desktop with as little clicking as possible:
locale, KDE Plasma look and feel, shortcuts, update-alternatives, PipeWire, camera
and package installation.

## Requirements

- `bash` 4.4 or newer
- KDE Plasma 6 for the `kde` tasks (`kwriteconfig6`, `plasma-apply-*`)
- Package installation is written for Debian/Ubuntu (`nala` or `apt`); the
  `pacman`/`dnf`/`zypper` fallbacks exist, but the default package names are
  Debian-specific
- `sudo` is used for individual system-changing commands, not for the whole run

## Usage

```bash
./setup.sh <command>
```

| Command | What it does |
| --- | --- |
| `all` | Run every task in `config/` and its subdirectories (skips tasks that need arguments) |
| `kde` | KDE Plasma settings, theme, shortcuts, taskbar/tray, krunner, kwin |
| `audio` | PipeWire null sink / virtual microphone |
| `locale` | Set the system locale (English UI, German formats) |
| `camera` | Install `v4l-utils`, check the camera, register Kamoso |
| `programs <url-or-path>` | Install the packages listed in an https URL or local file |
| `alternatives` | Apply `config/alternatives.yml` via `update-alternatives` |
| `python` | Install Python tooling and register the `python` alternative |
| `help` | Show usage |

Examples:

```bash
./setup.sh kde
./setup.sh programs ./packages.txt
./setup.sh alternatives
```

`all` runs every task even if one of them fails and prints a summary of the
failures at the end. Tasks that require arguments (for example `programs` and
`setupModularConfig.sh`) are skipped in that mode.

## Layout

```
setup.sh                     task runner
config/
  shared_functions.sh        shared helpers, sourced by the task scripts
  alternatives.yml           update-alternatives configuration
  ALTERNATIVES_README.md     details on the alternatives setup
  setup*.sh                  individual setup tasks
  Audio/                     PipeWire tasks
  KDE-plasma/                KDE Plasma tasks
  Thunderbird/               Thunderbird user.js
  VisualStudioCode/          VS Code keybindings (not installed automatically)
picture/                     images installed into the user's icon directory
tools/                       standalone helpers that are not setup tasks
  pw-chrome-monitor-links.sh PipeWire links for the virtual microphone
```

`config/shared_functions.sh` is a library and is sourced, never executed as a
task.

Three scripts can be run directly instead of through the task runner:

```bash
./config/setupKeybindings.sh                 # apply the KDE shortcuts only
./config/setupModularConfig.sh <module...>   # run selected setup modules
./tools/pw-chrome-monitor-links.sh           # after the PipeWire sink exists
```

The last one is not part of `./setup.sh audio`; run it after
`setupPipewireSink.sh` has created the sink, for example from autostart.

## TODO

- [x] copy TNS Logo see ./config/KDE-plasma/setupKDEdesktop-appletsrc.sh <br/>
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
  - [x] [Willow Dark](https://github.com/doncsugar/willow-theme/tree/main/aurorae-themes/WillowDark)
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
