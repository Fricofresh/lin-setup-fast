#!/usr/bin/env bash

# Shared functions for setup scripts

# Define color variables
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\033[1;33m'
RED='\033[0;31m'

# Function to print colored output
print_status() {
    local status_code=$1
    local message=$2
    
    case $status_code in
        success)
            echo -e "${GREEN}✓${NC} $message"
            ;;
        skip)
            echo -e "${YELLOW}⊘${NC} $message"
            ;;
        error)
            echo -e "${RED}✗${NC} $message"
            ;;
        info)
            echo -e "${YELLOW}ℹ${NC} $message"
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
    local packages=(thunderbird rclone nextcloud-desktop plasma-discover)
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

# Function to check if we're on KDE Plasma desktop
is_kde_plasma() {
    [[ "$DESKTOP_SESSION" == *"plasma"* ]] || [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]
}

# Function to determine where KDE configuration files are stored
get_kde_config_dir() {
    if [[ -n "${XDG_CONFIG_HOME:-}" ]]; then
        echo "$XDG_CONFIG_HOME"
    else
        echo "$HOME/.config"
    fi
}

# Function to check for existing keybindings file in standard location
check_keybinding_files() {
    local kde_config=$(get_kde_config_dir)
    
    # Check common KDE keybinding locations 
    if [[ -f "$kde_config/kdeglobal" ]] || [[ -f "$HOME/.config/kdeglobal" ]]; then
        echo "Found existing KDE global configuration"
        return 0
    fi
    
    # Try to locate KWin keybindings file (most likely location)
    local kwin_dir="$kde_config/kwinrc"
    if [[ -f "$kwin_dir" ]]; then
        echo "Found KWin config at: $kwin_dir"
        return 0
    fi
    
    echo "No existing keybinding configuration found"
    return 1
}

# Function to copy or import KDE keybindings 
import_kde_keybindings() {
    local kde_config=$(get_kde_config_dir)
    
    # Try common locations for plasma desktop settings
    local source_files=(
        "$script_dir/KDE-plasma/setupKDEshortcuts.sh"
        "$HOME/.config/kdeglobal"
        "$kde_config/kdeglobal"
    )
    
    echo "Checking keybinding files..."
    
    # Try to copy from existing scripts or check for standard KDE configs
    if [[ -f "$script_dir/KDE-plasma/setupKDEshortcuts.sh" ]]; then
        echo "Copying keybindings from setupKDEshortcuts.sh"
        cp "$script_dir/KDE-plasma/setupKDEshortcuts.sh" "$kde_config/setupKDEshortcuts.sh.backup" 2>/dev/null || true
        
        # Create a basic configuration file if needed 
        if [[ ! -f "$kde_config/kdeglobal" ]]; then
            mkdir -p "$kde_config"
            echo "# KDE Global Configuration" > "$kde_config/kdeglobal"
            echo "Created default kdeglobal config"
        fi
        
        return 0
    else
        echo "No keybinding source found, creating basic setup"
        # Create a minimal configuration file to avoid errors 
        mkdir -p "$kde_config"
        touch "$kde_config/kdeglobal"
        echo "Created basic kdeglobal config"
    fi
}

# Function to validate and fix permissions on keybindings  
validate_keybinding_files() {
    local kde_config=$(get_kde_config_dir)
    
    # Ensure proper file permissions
    if [[ -f "$kde_config/kdeglobal" ]]; then
        chmod 644 "$kde_config/kdeglobal"
    fi
    
    
    echo "Keybindings validated and set up successfully"
}

# Function to check if a specific module is available 
check_module() {
    local module_name="$1"  
    echo "Checking for module: $module_name"
    
    # Verify that the module exists and has proper permissions
    if [[ -f "$script_dir/$module_name.sh" ]] && [[ -x "$script_dir/$module_name.sh" ]]; then
        print_status success "Module $module_name found and executable"
        return 0
    else
        print_status error "Module $module_name not found or not executable"
        return 1
    fi
}

# Function to run a specific configuration module 
run_module() {
    local module="$1"
    
    if check_module "$module"; then
        echo "Running: $script_dir/$module.sh"  
        bash "$script_dir/$module.sh"
        print_status success "Completed: $module"
    else
        print_status warning "Could not execute $module - skipping."
    fi
}