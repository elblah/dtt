#!/bin/bash

# Simple install script for dtt (typing practice tool)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}DTT Installer${NC}"
echo "=================="

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DTT_SOURCE="$SCRIPT_DIR/dtt"

# Check if dtt script exists
if [ ! -f "$DTT_SOURCE" ]; then
    echo -e "${RED}Error: dtt script not found at $DTT_SOURCE${NC}"
    exit 1
fi

# Function to ask for bin directory with safe defaults
ask_bin_dir() {
    local default_dirs=("/usr/local/bin" "$HOME/bin" "/usr/bin")
    local suggested_dir=""
    
    # Find the first existing and writable directory from defaults
    for dir in "${default_dirs[@]}"; do
        if [ -d "$dir" ] && [ -w "$dir" ]; then
            suggested_dir="$dir"
            break
        fi
    done
    
    # If no writable default found, suggest ~/bin (will create if needed)
    if [ -z "$suggested_dir" ]; then
        suggested_dir="$HOME/bin"
        echo -e "${YELLOW}No writable default bin directory found.${NC}"
    fi
    
    echo ""
    echo "Where would you like to install the dtt symlink?"
    echo "Common bin directories:"
    echo "  1) /usr/local/bin (system-wide, requires sudo)"
    echo "  2) $HOME/bin (user-only, will create if needed)"
    echo "  3) Custom directory"
    echo ""
    echo -e "Suggested: ${GREEN}$suggested_dir${NC}"
    echo ""
    
    while true; do
        read -p "Enter bin directory path or press Enter for [$suggested_dir]: " user_input
        
        # Use suggested if user presses Enter
        if [ -z "$user_input" ]; then
            BIN_DIR="$suggested_dir"
            break
        fi
        
        # Check if user entered a number
        case "$user_input" in
            1) BIN_DIR="/usr/local/bin"; break ;;
            2) BIN_DIR="$HOME/bin"; break ;;
            3) 
                read -p "Enter custom bin directory path: " custom_dir
                if [ -n "$custom_dir" ]; then
                    BIN_DIR="$custom_dir"
                    break
                else
                    echo -e "${RED}Please enter a valid path.${NC}"
                fi
                ;;
            *) 
                BIN_DIR="$user_input"
                # Check if the path looks valid
                if [[ "$BIN_DIR" == /* ]]; then
                    break
                else
                    echo -e "${RED}Please enter an absolute path (starting with /).${NC}"
                fi
                ;;
        esac
    done
}

# Ask user for bin directory
ask_bin_dir

echo ""
echo -e "Selected bin directory: ${GREEN}$BIN_DIR${NC}"

# Create bin directory if it doesn't exist (for ~/bin case)
if [ ! -d "$BIN_DIR" ]; then
    echo -e "${YELLOW}Creating directory: $BIN_DIR${NC}"
    if mkdir -p "$BIN_DIR"; then
        echo -e "${GREEN}Directory created successfully.${NC}"
    else
        echo -e "${RED}Failed to create directory $BIN_DIR${NC}"
        exit 1
    fi
fi

# Check if we can write to the bin directory
if [ ! -w "$BIN_DIR" ]; then
    echo -e "${YELLOW}Warning: Cannot write to $BIN_DIR${NC}"
    echo "You may need sudo privileges for system-wide installation."
    read -p "Try with sudo? [y/N]: " use_sudo
    
    if [[ "$use_sudo" =~ ^[Yy]$ ]]; then
        SUDO="sudo"
    else
        echo -e "${RED}Installation aborted.${NC}"
        exit 1
    fi
else
    SUDO=""
fi

# Remove existing symlink if it exists
DTT_TARGET="$BIN_DIR/dtt"
if [ -L "$DTT_TARGET" ] || [ -f "$DTT_TARGET" ]; then
    echo -e "${YELLOW}Removing existing dtt at $DTT_TARGET${NC}"
    $SUDO rm -f "$DTT_TARGET"
fi

# Create the symlink
echo -e "${YELLOW}Creating symlink from $DTT_SOURCE to $DTT_TARGET${NC}"
if $SUDO ln -s "$DTT_SOURCE" "$DTT_TARGET"; then
    echo -e "${GREEN}✓ Symlink created successfully!${NC}"
    
    # Make sure the source script is executable
    chmod +x "$DTT_SOURCE"
    
    echo ""
    echo -e "${GREEN}Installation complete!${NC}"
    echo ""
    echo "You can now run 'dtt' from anywhere."
    echo ""
    echo "To uninstall, run:"
    echo "  $SUDO rm -f '$DTT_TARGET'"
    echo ""
    
    # Test if the bin directory is in PATH
    if [[ ":$PATH:" == *":$BIN_DIR:"* ]]; then
        echo -e "${GREEN}✓ $BIN_DIR is already in your PATH${NC}"
    else
        echo -e "${YELLOW}⚠ $BIN_DIR is not in your PATH${NC}"
        echo "You may need to add it to your shell profile:"
        case "$SHELL" in
            */bash) echo "  echo 'export PATH=\"\$PATH:$BIN_DIR\"' >> ~/.bashrc" ;;
            */zsh)  echo "  echo 'export PATH=\"\$PATH:$BIN_DIR\"' >> ~/.zshrc" ;;
            *)      echo "  Add 'export PATH=\"\$PATH:$BIN_DIR\"' to your shell profile" ;;
        esac
        echo "Then run: source ~/.bashrc (or restart your terminal)"
    fi
else
    echo -e "${RED}Failed to create symlink.${NC}"
    exit 1
fi