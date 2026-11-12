#!/usr/bin/env bash
set -euo pipefail

# Language is English, while regional representation (numbers, dates, currency,
# measurement) is German. Keep LC_MESSAGES English so the UI stays English too.
LANG_VALUE="en_US.UTF-8"
REGION_VALUE="de_DE.UTF-8"

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
    sudo_cmd=(sudo)
else
    sudo_cmd=()
fi

"${sudo_cmd[@]}" localectl set-locale \
    LANG="$LANG_VALUE" \
    LANGUAGE="en_US:en" \
    LC_MESSAGES="$LANG_VALUE" \
    LC_COLLATE="$REGION_VALUE" \
    LC_NUMERIC="$REGION_VALUE" \
    LC_TIME="$REGION_VALUE" \
    LC_MONETARY="$REGION_VALUE" \
    LC_ADDRESS="$REGION_VALUE" \
    LC_IDENTIFICATION="$REGION_VALUE" \
    LC_MEASUREMENT="$REGION_VALUE" \
    LC_PAPER="$REGION_VALUE" \
    LC_TELEPHONE="$REGION_VALUE" \
    LC_NAME="$REGION_VALUE"
