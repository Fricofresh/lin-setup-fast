#!/usr/bin/env bash
# Written partially with AI
 
set -euo pipefail

# Source shared functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../shared_functions.sh"

# Check for required commands
require_command systemctl

echo -e "${YELLOW}Setting up PipeWire null audio sink...${NC}"

CONFIG_DIR="/etc/pipewire/pipewire.conf.d"
CONFIG_FILE="${CONFIG_DIR}/10-pw-sink.conf"

# Create config directory if it doesn't exist
if [[ ! -d "$CONFIG_DIR" ]]; then
    print_status info "Creating config directory: ${CONFIG_DIR}"
    sudo mkdir -p "$CONFIG_DIR"
fi

# Write the configuration file
if ! cat << 'EOF' | sudo tee "$CONFIG_FILE" > /dev/null
context.objects = [
    {   factory = adapter
        args = {
            factory.name     = support.null-audio-sink
            node.name        = "pw-effects"
            node.description = "pw-effects audio sink"
            media.class      = Audio/Sink
            audio.rate       = 48000
            audio.channels   = 2
            audio.position   = [ FL FR ]
            object.linger    = true
            monitor.channel-volumes = true
            monitor.passthrough = true
        }
    }

    { factory = adapter
        args = {
            factory.name     = support.null-audio-sink
            node.name        = "Microphone-Sink"
            node.description = "Microphone"
            media.class      = "Audio/Source/Virtual"
            audio.position   = "FL,FR"
            monitor.passthrough = true
        }
    }
]
EOF
then
    print_status error "Failed to write configuration file"
    exit 1
fi

print_status success "Configuration written to ${CONFIG_FILE}"

# Restart PipeWire services to apply changes (user services, no sudo needed)
print_status info "Restarting PipeWire services..."
if ! systemctl --user restart pipewire pipewire-pulse wireplumber; then
    print_status warning "Could not restart PipeWire automatically. Please restart manually or reboot."
fi

print_status success "PipeWire setup complete!"
