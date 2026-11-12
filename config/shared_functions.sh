#!/usr/bin/env bash

# Shared functions for setup scripts

# Define color variables
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\033[1;33m'
RED='\033[0;31m'

# Function to print colored output
print_status() {
    local status_code="$1"
    local message="$2"

    case $status_code in
        success)
            echo -e "${GREEN}✓${NC} $message"
            ;;
        skip)
            echo -e "${YELLOW}⊘${NC} $message"
            ;;
        warning)
            echo -e "${YELLOW}!${NC} $message"
            ;;
        error)
            echo -e "${RED}✗${NC} $message"
            ;;
        info)
            echo -e "${YELLOW}ℹ${NC} $message"
            ;;
        *)
            echo "$message"
            ;;
    esac
}

# Function to detect package manager with fallbacks
detect_package_manager() {
    # Check for common package managers in order of preference
    if command -v nala >/dev/null 2>&1; then
        echo "nala"
    elif command -v apt >/dev/null 2>&1; then
        echo "apt"
    elif command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    elif command -v zypper >/dev/null 2>&1; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Function to install packages (using package manager)
install_packages() {
    local pm
    pm="$(detect_package_manager)"
    local packages=("$@")

    if [[ ${#packages[@]} -eq 0 ]]; then
        packages=(thunderbird rclone nextcloud-desktop plasma-discover)
    fi

    case "$pm" in
        nala)
            sudo nala update
            sudo nala install -y "${packages[@]}"
            ;;
        apt)
            sudo apt update
            sudo apt install -y "${packages[@]}"
            ;;
        pacman)
            sudo pacman -Syu --needed "${packages[@]}"
            ;;
        dnf)
            sudo dnf install -y "${packages[@]}"
            ;;
        zypper)
            sudo zypper install -y "${packages[@]}"
            ;;
        *)
            echo "No supported package manager detected. Install: ${packages[*]}"
            ;;
    esac
}

# Function to require a command is installed
require_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: required command '$1' is not installed." >&2
        exit 1
    fi
}

# Function to check if we're on KDE Plasma desktop
is_kde_plasma() {
    [[ "$DESKTOP_SESSION" == *"plasma"* ]] || [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]
}

# Function to determine where KDE configuration files are stored
get_kde_config_dir() {
    echo "${XDG_CONFIG_HOME:-$HOME/.config}"
}
