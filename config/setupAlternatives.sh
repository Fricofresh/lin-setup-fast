#!/usr/bin/env bash

# Created with AI

# setupAlternatives.sh - Manage update-alternatives from a single configuration file
# This script reads alternatives.yml and sets up alternatives for installed programs

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/alternatives.yml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Check if config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    print_status error "Config file not found: $CONFIG_FILE"
    exit 1
fi

# Check if yq is installed and install if needed
if ! command -v yq &> /dev/null; then
    print_status error "yq is not installed"
    echo ""
    
    # Check if nala is available
    if command -v nala &> /dev/null; then
        echo "Available package managers: nala, apt"
        package_manager="nala"
    else
        echo "Available package manager: apt"
        package_manager="apt"
    fi
     
    print_status info "Installing yq using $package_manager..."
    
    if sudo "$package_manager" install -y yq &> /dev/null; then
        print_status success "yq installed successfully"
    else
        print_status error "Failed to install yq. Please install it manually with: sudo $package_manager install yq"
        exit 1
    fi
fi

print_status info "Starting update-alternatives setup from $CONFIG_FILE"
echo ""

# Counters
total_lines=0
processed=0
skipped=0
failed=0
iteration=0

# Parse YAML and convert to pipe-separated format for processing
# Format: command_name|program_path|priority
print_status info "Parsing YAML file: $CONFIG_FILE"
yaml_data=$(yq '.alternatives[] | .command + "|" + .path + "|" + (.priority | tostring)' "$CONFIG_FILE") || {
    print_status error "Failed to parse YAML file: $CONFIG_FILE"
    print_status error "yq output: $(yq '.alternatives[] | .command + "|" + .path + "|" + (.priority | tostring)' "$CONFIG_FILE" 2>&1)"
    exit 1
}

if [[ -z "$yaml_data" ]]; then
    print_status error "No alternatives found in config file: $CONFIG_FILE"
    exit 1
fi

print_status info "Parsed alternatives:"
echo "$yaml_data"
echo ""

# Read parsed data line by line using array approach
IFS=$'\n' read -r -d '' -a alternatives_array <<< "$yaml_data"

for alt_line in "${alternatives_array[@]}"; do
    ((iteration++))
    echo "iteration $iteration"
    # Skip empty lines
    [[ -z "$alt_line" ]] && continue
    
    ((total_lines++))
    
    # Split the line by |
    IFS='|' read -r command_name program_path priority <<< "$alt_line"
    
    # Trim whitespace using sed instead of xargs to avoid quote issues
    command_name=$(echo "$command_name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    program_path=$(echo "$program_path" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    priority=$(echo "$priority" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # Validate parsed values
    if [[ -z "$command_name" || -z "$program_path" || -z "$priority" ]]; then
        print_status error "Invalid config entry (skipping): $command_name|$program_path|$priority"
        ((skipped++))
        continue
    fi
    
    # Check if the program exists
    if [[ ! -f "$program_path" ]]; then
        print_status skip "Program not found: $program_path (for command: $command_name)"
        ((skipped++))
        continue
    fi
    
    # Check if it's executable
    if [[ ! -x "$program_path" ]]; then
        print_status error "Program is not executable: $program_path"
        ((failed++))
        continue
    fi
    
    # Set up the alternative
    if sudo update-alternatives --install /usr/bin/"$command_name" "$command_name" "$program_path" "$priority" 2>/dev/null; then
        print_status success "Alternative set: /usr/bin/$command_name -> $program_path (priority: $priority)"
        ((processed++))
    else
        print_status error "Failed to set alternative: $command_name"
        ((failed++))
    fi
    
done

# Summary
echo ""
echo "═══════════════════════════════════════════════════════"
print_status info "Setup completed"
echo "  Total configs:   $total_lines"
echo "  Processed:       $processed"
echo "  Skipped:         $skipped"
echo "  Failed:          $failed"
echo "═══════════════════════════════════════════════════════"

# Return appropriate exit code
if [[ $failed -gt 0 ]]; then
    exit 1
fi

exit 0