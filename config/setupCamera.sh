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

IS_KAMOSO_INSTALLED=${command -v kamoso &> /dev/null}
# Install Kamoso if it's not already installed to use the camera if it's not installed
if ! $IS_KAMOSO_INSTALLED; then
    echo "Kamoso is not installed. Installing Kamoso..."
    sudo ${PACKAGE_MANAGER} install kamoso
else
    echo "Kamoso is already installed."
fi

# add update-alternative for kamoso if it's not already set to Camera and Kamera
if $IS_KAMOSO_INSTALLED; then
    echo "Kamoso is installed, setting up update-alternatives for Camera and Kamera..."
    # Add update-alternatives for Kamoso, setting the default to Camera and Kamera
    sudo update-alternatives --install /usr/bin/camera camera /usr/bin/kamoso 60 --slave /usr/bin/kamera kamera /usr/bin/kamoso
fi

