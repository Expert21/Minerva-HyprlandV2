#!/usr/bin/env bash
# =============================================================================
# Minerva Installation Script
# Obsidian · Sapphire · Tyrian Hyprland Rice
# =============================================================================

set -euo pipefail
IFS=$'\n\t'

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"


# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

print_header() {
    echo -e "\n${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${PURPLE}  🜂 $1${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_step() {
    echo -e "${CYAN}▸${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# -----------------------------------------------------------------------------
# System Checks (must be after helper functions)
# -----------------------------------------------------------------------------

command -v pacman >/dev/null 2>&1 || {
    print_error "pacman not found. This installer is for Arch-based distros."
    exit 1
}

command -v sudo >/dev/null 2>&1 || {
    print_error "sudo not found. Install sudo or run as root (not recommended)."
    exit 1
}

backup_if_exists() {
  local path="$1"
  if [[ -e "$path" && ! -L "$path" ]]; then
    mkdir -p "$BACKUP_DIR"
    local rel="${path#$HOME/}"                 # strip $HOME/ prefix
    local dest="$BACKUP_DIR/$rel"
    mkdir -p "$(dirname "$dest")"
    print_warning "Backing up existing $rel to $dest"
    mv "$path" "$dest"
  elif [[ -L "$path" ]]; then
    rm "$path"
  fi
}

create_symlink() {
    local source="$1"
    local target="$2"
    local name=$(basename "$target")
    
    backup_if_exists "$target"
    
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    print_success "Linked $name"
}

# -----------------------------------------------------------------------------
# Installation Functions
# -----------------------------------------------------------------------------

install_hyprland_config() {
    print_header "Hyprland Configuration"
    
    create_symlink "$SCRIPT_DIR/hypr" "$CONFIG_DIR/hypr"
}

install_waybar_config() {
    print_header "Waybar Configuration"
    
    create_symlink "$SCRIPT_DIR/waybar" "$CONFIG_DIR/waybar"
}

install_dunst_config() {
    print_header "Dunst Configuration"
    
    create_symlink "$SCRIPT_DIR/dunst" "$CONFIG_DIR/dunst"
}

install_rofi_config() {
    print_header "Rofi Configuration"
    
    create_symlink "$SCRIPT_DIR/rofi" "$CONFIG_DIR/rofi"
}

install_wezterm_config() {
    print_header "Wezterm Configuration"
    
    create_symlink "$SCRIPT_DIR/wezterm" "$CONFIG_DIR/wezterm"
}

install_yazi_config() {
    print_header "Yazi Configuration"
    
    create_symlink "$SCRIPT_DIR/yazi" "$CONFIG_DIR/yazi"
}

install_starship_config() {
    print_header "Starship Configuration"
    
    create_symlink "$SCRIPT_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
}

install_micro_config() {
    print_header "Micro Editor Configuration"
    
    # Create micro config directory
    mkdir -p "$CONFIG_DIR/micro/colorschemes"
    
    # Link settings
    create_symlink "$SCRIPT_DIR/micro/settings.json" "$CONFIG_DIR/micro/settings.json"
    
    # Link colorscheme
    create_symlink "$SCRIPT_DIR/micro/colorschemes/obsidian-tyrian.micro" \
                   "$CONFIG_DIR/micro/colorschemes/obsidian-tyrian.micro"
}

install_firefox_config() {
    print_header "Firefox Configuration"
    
    # Find Firefox profile
    local ff_dir="$HOME/.mozilla/firefox"
    
    if [[ ! -d "$ff_dir" ]]; then
        print_warning "Firefox directory not found. Skipping Firefox theme."
        print_step "Install Firefox and run this script again to apply the theme."
        return
    fi
    
    # Find the default-release profile
    local profile_dir=$(find "$ff_dir" -maxdepth 1 -name "*.default-release" -type d | head -1)
    
    if [[ -z "$profile_dir" ]]; then
        # Try default profile
        profile_dir=$(find "$ff_dir" -maxdepth 1 -name "*.default" -type d | head -1)
    fi
    
    if [[ -z "$profile_dir" ]]; then
        print_warning "No Firefox profile found. Skipping Firefox theme."
        print_step "Start Firefox once to create a profile, then run this script again."
        return
    fi
    
    print_step "Found profile: $(basename "$profile_dir")"
    
    # Create chrome directory
    mkdir -p "$profile_dir/chrome"
    
    # Copy Firefox configs (copy instead of symlink for Firefox)
    cp "$SCRIPT_DIR/firefox/chrome/userChrome.css" "$profile_dir/chrome/"
    cp "$SCRIPT_DIR/firefox/chrome/userContent.css" "$profile_dir/chrome/"
    cp "$SCRIPT_DIR/firefox/user.js" "$profile_dir/"
    
    print_success "Firefox theme installed"
    print_step "Restart Firefox to apply changes"
}

check_dependencies() {
    print_header "Checking Dependencies"
    
    local missing=()
    
    # All required packages
    local packages=(
        # Core WM
        "hyprland"
        "hyprlock"
        "hypridle"
        "xdg-desktop-portal-hyprland"
        
        # Bar & Launcher
        "waybar"
        "rofi-wayland"
        
        # Notifications
        "dunst"
        
        # Terminal & Shell
        "wezterm"
        "zsh"
        "starship"
        
        # File Manager
        "yazi"
        
        # Editor
        "micro"
        
        # Wallpaper
        "swww"
        
        # Screenshot
        "hyprshot"
        "swappy"
        
        # Clipboard
        "wl-clipboard"
        "cliphist"
        
        # Auth
        "polkit"
        "polkit-gnome"
        
        # Fonts
        "ttf-jetbrains-mono"
        "ttf-jetbrains-mono-nerd"
        
        # Browser
        "firefox"
    )
    
    print_step "Checking installed packages..."
    echo ""
    
    for pkg in "${packages[@]}"; do
        if pacman -Qi "$pkg" &> /dev/null 2>&1; then
            print_success "$pkg"
        else
            missing+=("$pkg")
            print_error "$pkg (missing)"
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo ""
        print_warning "Missing ${#missing[@]} package(s): ${missing[*]}"
        echo ""
        read -p "Install missing packages now? [Y/n] " -n 1 -r
        echo
        
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            print_step "Installing packages..."
            echo ""
            
            if sudo pacman -S --needed "${missing[@]}"; then
                print_success "All packages installed successfully"
            else
                print_error "Package installation failed"
                echo ""
                read -p "Continue with config installation anyway? [y/N] " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    exit 1
                fi
            fi
        else
            echo ""
            read -p "Continue without installing packages? [y/N] " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        fi
    else
        echo ""
        print_success "All packages are installed!"
    fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

main() {
    clear
    echo -e "${PURPLE}"
    cat << "EOF"
    
    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║   🜂  M I N E R V A                                       ║
    ║                                                           ║
    ║   Obsidian · Sapphire · Tyrian                           ║
    ║   Hyprland Rice Installer                                ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

EOF
    echo -e "${NC}"
    
    echo -e "${CYAN}Source:${NC} $SCRIPT_DIR"
    echo -e "${CYAN}Target:${NC} $CONFIG_DIR"
    echo ""
    
    # Check dependencies
    check_dependencies
    
    # Confirm installation
    echo ""
    read -p "Proceed with installation? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        print_error "Installation cancelled."
        exit 0
    fi
    
    # Install all configs
    install_hyprland_config
    install_waybar_config
    install_dunst_config
    install_rofi_config
    install_wezterm_config
    install_yazi_config
    install_starship_config
    install_micro_config
    install_firefox_config
    
    # Summary
    print_header "Installation Complete"
    
    if [[ -d "$BACKUP_DIR" ]]; then
        print_step "Backups saved to: $BACKUP_DIR"
    fi
    
    echo ""
    echo -e "${GREEN}Next steps:${NC}"
    echo -e "  1. Log out and log back in (or restart Hyprland)"
    echo -e "  2. Restart Firefox to apply the theme"
    echo -e "  3. Edit ${CYAN}~/.config/hypr/master.conf${NC} for customization"
    echo ""
    echo -e "${PURPLE}Enjoy your new rice! 🜂${NC}"
    echo ""
}

# Run main function
main "$@"
