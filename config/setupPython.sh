#!/usr/bin/env bash
set -euo pipefail

# Check if nala exists, otherwise use apt for package management
if command -v nala &> /dev/null; then
    PACKAGE_MANAGER="nala"
else
    PACKAGE_MANAGER="apt"
fi

echo "Using package manager: $PACKAGE_MANAGER"

PYTHON_PACKAGES=(python3 python3-pip pipx)
if ! command -v python3 &> /dev/null; then
    echo "Installing Python packages: ${PYTHON_PACKAGES[*]}"
    sudo "$PACKAGE_MANAGER" install "${PYTHON_PACKAGES[@]}"
else
    echo "Python packages are already installed."
fi

python3_path="$(command -v python3)"
if [[ -z "$python3_path" ]]; then
    echo "Error: python3 is not installed, cannot set up the python alternative." >&2
    exit 1
fi

PYTHON_VERSION="$(python3 --version 2>&1 | awk '{print $2}' | cut -d. -f1,2 | tr -d '.')"
if [[ -z "$PYTHON_VERSION" ]]; then
    echo "Error: could not determine the python3 version." >&2
    exit 1
fi

# Set up python alternatives using update-alternatives
sudo update-alternatives --install /usr/bin/python python "$python3_path" "$PYTHON_VERSION"
