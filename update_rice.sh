#!/bin/bash

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                    CachyOS Hyprland Rice Updater            ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Script to update your live configuration from the repository

# set -e  # Exit on any error (disabled to prevent early exit)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Repository path
REPO_PATH="$HOME/github/cachyOs-hyprland"
CONFIG_PATH="$HOME/.config"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to backup existing config
backup_config() {
    local config_name=$1
    local backup_path="$CONFIG_PATH/${config_name}.backup.$(date +%Y%m%d_%H%M%S)"
    
    if [ -d "$CONFIG_PATH/$config_name" ]; then
        print_warning "Backing up existing $config_name configuration to: $backup_path"
        cp -r "$CONFIG_PATH/$config_name" "$backup_path"
        return 0
    fi
    return 1
}

# Function to copy configuration
copy_config() {
    local config_name=$1
    local source_path="$REPO_PATH/$config_name"
    local dest_path="$CONFIG_PATH/$config_name"
    
    if [ -d "$source_path" ]; then
        print_status "Copying $config_name configuration..."
        
        # Create backup if config exists
        backup_config "$config_name"
        
        # Copy new configuration
        cp -r "$source_path" "$CONFIG_PATH/"
        print_success "$config_name configuration updated"
        return 0
    else
        print_error "$config_name not found in repository"
        return 1
    fi
}

# Main function
main() {
    echo -e "${BLUE}"
    echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
    echo "┃                CachyOS Hyprland Rice Updater                ┃"
    echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
    echo -e "${NC}"
    
    # Check if repository exists
    if [ ! -d "$REPO_PATH" ]; then
        print_error "Repository not found at: $REPO_PATH"
        exit 1
    fi
    
    print_status "Repository found at: $REPO_PATH"
    print_status "Target configuration directory: $CONFIG_PATH"
    echo
    
    # List of configurations to update
    configs=("hypr" "waybar" "alacritty" "fish" "wofi" "wlogout" "mako" "swaylock")
    
    # Ask for confirmation
    echo -e "${YELLOW}This will update the following configurations:${NC}"
    for config in "${configs[@]}"; do
        echo "  • $config"
    done
    echo
    
    read -p "Do you want to continue? (y/N): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        print_warning "Operation cancelled by user"
        exit 0
    fi
    
    echo
    print_status "Starting configuration update..."
    echo
    
    # Update each configuration
    updated_count=0
    failed_count=0
    
    for config in "${configs[@]}"; do
        if copy_config "$config"; then
            ((updated_count++))
        else
            ((failed_count++))
        fi
    done
    
    echo
    print_status "Making scripts executable..."
    
    # Make scripts executable
    if [ -d "$CONFIG_PATH/hypr/scripts" ]; then
        chmod +x "$CONFIG_PATH/hypr/scripts/"*
        print_success "Hypr scripts made executable"
    fi
    
    if [ -d "$CONFIG_PATH/waybar" ]; then
        chmod +x "$CONFIG_PATH/waybar/"*.sh 2>/dev/null || true
        chmod +x "$CONFIG_PATH/waybar/modules/"*.sh 2>/dev/null || true
        print_success "Waybar scripts made executable"
    fi
    
    echo
    print_status "Reloading configurations..."
    
    # Note: Hyprland automatically reloads configuration
    print_success "Hyprland will automatically reload the configuration"
    
    # Handle Waybar restart
    if pgrep -x "waybar" > /dev/null; then
        print_status "Stopping Waybar..."
        killall waybar 2>/dev/null || true
        sleep 1
    fi
    
    # Try to start Waybar
    print_status "Attempting to start Waybar..."
    if waybar </dev/null &>/dev/null & then
        sleep 1
        if pgrep -x "waybar" > /dev/null; then
            print_success "Waybar started successfully"
        else
            print_warning "Waybar failed to start. Run 'waybar &' manually if needed."
        fi
    else
        print_warning "Could not start Waybar. Run 'waybar &' manually if needed."
    fi
    
    # Final summary
    echo
    echo -e "${GREEN}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${NC}"
    echo -e "${GREEN}┃                        Update Summary                       ┃${NC}"
    echo -e "${GREEN}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}"
    echo
    print_success "Configurations updated: $updated_count"
    if [ $failed_count -gt 0 ]; then
        print_warning "Configurations failed: $failed_count"
    fi
    echo
    print_success "Rice update completed! Your configuration should now be active."
    
    if [ $failed_count -eq 0 ]; then
        echo -e "${GREEN}🎉 All configurations updated successfully!${NC}"
    fi
}

# Check if script is run with --help or -h
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "CachyOS Hyprland Rice Updater"
    echo
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "This script copies configuration files from your git repository"
    echo "to your ~/.config directory and reloads the applications."
    echo
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo
    echo "Configurations updated:"
    echo "  • Hyprland (hypr/)"
    echo "  • Waybar (waybar/)"
    echo "  • Alacritty (alacritty/)"
    echo "  • Fish shell (fish/)"
    echo "  • Wofi launcher (wofi/)"
    echo "  • WLogout (wlogout/)"
    echo "  • Mako notifications (mako/)"
    echo "  • Swaylock (swaylock/)"
    echo
    echo "Backups are automatically created with timestamp suffixes."
    exit 0
fi

# Run main function
main
