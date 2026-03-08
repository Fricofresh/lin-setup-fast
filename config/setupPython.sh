#!/bin/bash

# Check if nala exists, otherwise use apt for package management
if command -v nala &> /dev/null; then
    PACKAGE_MANAGER="nala"
else
    PACKAGE_MANAGER="apt"
fi

echo "Using package manager: $PACKAGE_MANAGER"

PYTHON_PACKAGES="python3 python3-pip pipx"
# Check if nala exists, otherwise use apt for package management
if ! command -v python3 &> /dev/null; then
    echo "Installing Python packages: $PYTHON_PACKAGES"
    sudo ${PACKAGE_MANAGER} install ${PYTHON_PACKAGES}
else
    echo "Python packages are already installed."
fi

PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}' | cut -d. -f1,2 | tr -d '.')

# Set up python alternatives using update-alternatives
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 "$PYTHON_VERSION"
