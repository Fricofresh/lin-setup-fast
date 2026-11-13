#!/usr/bin/env bash
set -euo pipefail

kwriteconfig6 --file ~/.config/krunnerrc --group General --key FreeFloating "true"
kwriteconfig6 --file ~/.config/krunnerrc --group Plugins --key browsertabsEnabled "false"
