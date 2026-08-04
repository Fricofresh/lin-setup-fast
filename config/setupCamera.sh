#!/bin/bash

# Created with AI

# Check if nala exists, otherwise use apt for package management
if command -v nala &> /dev/null; then
    PACKAGE_MANAGER="nala"
else
    PACKAGE_MANAGER="apt"
fi

echo "Using package manager: $PACKAGE_MANAGER"

if ! command -v v4l2-ctl &> /dev/null; then
    echo "v4l-utils is not installed. Installing v4l-utils..."
    sudo ${PACKAGE_MANAGER} install v4l-utils
else 
    echo "v4l-utils is already installed."
fi


# Check if the camera is connected and get its name
if ls /dev/video* | grep -q video0; then
    camera_name=$(v4l2-ctl --list-devices | sed '/^$/d' | head -n1)
    echo "Camera is connected: $camera_name"
else
    echo "Camera is not connected"
fi

kamoso_path=$(command -v kamoso || true)

if [[ -z "$kamoso_path" ]]; then
    echo "Kamoso is not installed. Installing Kamoso..."
    sudo ${PACKAGE_MANAGER} install -y kamoso
    kamoso_path=$(command -v kamoso || true)
fi

if [[ -n "$kamoso_path" ]]; then
    echo "Kamoso is installed at: $kamoso_path"
    echo "Kamoso is installed, setting up update-alternatives for Camera and Kamera..."
    sudo update-alternatives --install /usr/bin/camera camera "$kamoso_path" 60 --slave /usr/bin/kamera kamera "$kamoso_path"
else
    echo "Failed to install or locate kamoso. Skipping update-alternatives setup."
    exit 1
fi

