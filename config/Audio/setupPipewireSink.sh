#!/bin/bash
# Written partially with AI
 
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CONFIG_DIR="/etc/pipewire/pipewire.conf.d"
CONFIG_FILE="${CONFIG_DIR}/10-pw-sink.conf"

echo -e "${YELLOW}Setting up PipeWire null audio sink...${NC}"

# Create config directory if it doesn't exist
if [[ ! -d "$CONFIG_DIR" ]]; then
    echo -e "${YELLOW}Creating config directory: ${CONFIG_DIR}${NC}"
    sudo mkdir -p "$CONFIG_DIR"
fi

# Write the configuration file
cat << 'EOF' | sudo tee "$CONFIG_FILE" > /dev/null
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
]
EOF

if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}✓ Configuration written to ${CONFIG_FILE}${NC}"
else
    echo -e "${RED}✗ Failed to write configuration file${NC}"
    exit 1
fi

# Restart PipeWire services to apply changes (user services, no sudo needed)
echo -e "${YELLOW}Restarting PipeWire services...${NC}"
systemctl --user restart pipewire pipewire-pulsewire 2>/dev/null || \
systemctl --user restart pipewire pipewire-pulse 2>/dev/null || \
echo -e "${YELLOW}⚠ Could not restart PipeWire automatically. Please restart manually or reboot.${NC}"

echo -e "${GREEN}✓ PipeWire setup complete!${NC}"
