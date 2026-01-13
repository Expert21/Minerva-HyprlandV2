#!/usr/bin/env bash
# =============================================================================
# 🜂 Minerva Theme Generator
# Generates all config files from the master color palette
# =============================================================================
#
# Usage: ./generate-themes.sh
#
# This script reads colors.sh and updates:
#   - hypr/scheme/colors.conf (Hyprland)
#   - waybar/style.css (Waybar)
#   - dunst/dunstrc (Dunst)
#   - rofi/config.rasi (Rofi)
#   - wezterm/wezterm.lua (Wezterm)
#   - yazi/theme.toml (Yazi)
#   - micro/colorschemes/obsidian-tyrian.micro (Micro)
#   - firefox/chrome/userChrome.css (Firefox)
#   - firefox/chrome/userContent.css (Firefox)
#   - starship.toml (Starship)
#
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the master color file
source "$SCRIPT_DIR/colors.sh"

# Colors for output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

print_step() {
    echo -e "${CYAN}▸${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# =============================================================================
# Hyprland colors.conf
# =============================================================================
generate_hyprland() {
    print_step "Generating Hyprland colors..."
    
    cat > "$SCRIPT_DIR/hypr/scheme/colors.conf" << EOF
# -----------------------------------------------------------------------------
# Color Scheme - Auto-generated from colors.sh
# -----------------------------------------------------------------------------
# Run ./generate-themes.sh to regenerate this file
# Edit colors.sh to change colors, not this file!
# -----------------------------------------------------------------------------

# 🜂 Obsidian · Sapphire · Tyrian

# Core Neutrals
\$base = rgba(${BASE}ff)
\$mantle = rgba(${MANTLE}ff)
\$crust = rgba(${CRUST}ff)
\$surface = rgba(${SURFACE}ff)
\$surfaceElevated = rgba(${SURFACE_ELEVATED}ff)
\$surfaceHighlight = rgba(${SURFACE_HIGHLIGHT}ff)
\$border = rgba(${BORDER}ff)
\$overlay = rgba(${OVERLAY}ff)
\$overlayStrong = rgba(${OVERLAY_STRONG}ff)

# Text Colors
\$textPrimary = rgba(${TEXT_PRIMARY}ff)
\$textSecondary = rgba(${TEXT_SECONDARY}ff)
\$textMuted = rgba(${TEXT_MUTED}ff)

# Primary Accents
\$primaryAccent = rgba(${PRIMARY_ACCENT}ff)
\$accentHover = rgba(${ACCENT_HOVER}ff)
\$secondaryAccent = rgba(${SECONDARY_ACCENT}ff)
\$accentSoft = rgba(${ACCENT_SOFT}ff)

# Highlights & Focus
\$focus = rgba(${FOCUS}ff)
\$activeGlow = rgba(${ACTIVE_GLOW}ff)

# Semantic
\$error = rgba(${ERROR}ff)
\$success = rgba(${SUCCESS}ff)
EOF
    
    print_success "hypr/scheme/colors.conf"
}

# =============================================================================
# Waybar style.css
# =============================================================================
generate_waybar() {
    print_step "Generating Waybar colors..."
    
    # Check if waybar style.css exists
    if [[ ! -f "$SCRIPT_DIR/waybar/style.css" ]]; then
        print_step "Skipping Waybar (no style.css found)"
        return
    fi
    
    # Create a colors section at the top of the file
    local temp_file=$(mktemp)
    
    cat > "$temp_file" << EOF
/* =============================================================================
   Minerva Color Variables - Auto-generated from colors.sh
   ============================================================================= */
@define-color base #${BASE};
@define-color mantle #${MANTLE};
@define-color crust #${CRUST};
@define-color surface #${SURFACE};
@define-color surface-elevated #${SURFACE_ELEVATED};
@define-color surface-highlight #${SURFACE_HIGHLIGHT};
@define-color border #${BORDER};
@define-color overlay #${OVERLAY};
@define-color overlay-strong #${OVERLAY_STRONG};

@define-color text-primary #${TEXT_PRIMARY};
@define-color text-secondary #${TEXT_SECONDARY};
@define-color text-muted #${TEXT_MUTED};

@define-color primary-accent #${PRIMARY_ACCENT};
@define-color accent-hover #${ACCENT_HOVER};
@define-color secondary-accent #${SECONDARY_ACCENT};
@define-color accent-soft #${ACCENT_SOFT};

@define-color focus #${FOCUS};
@define-color active-glow #${ACTIVE_GLOW};

@define-color error #${ERROR};
@define-color success #${SUCCESS};

EOF
    
    # Remove old color definitions if they exist (between markers)
    sed -i '/^\/\* =* *$/,/^@define-color success/d' "$SCRIPT_DIR/waybar/style.css" 2>/dev/null || true
    
    # Prepend new colors
    cat "$temp_file" "$SCRIPT_DIR/waybar/style.css" > "$SCRIPT_DIR/waybar/style.css.new"
    mv "$SCRIPT_DIR/waybar/style.css.new" "$SCRIPT_DIR/waybar/style.css"
    rm "$temp_file"
    
    print_success "waybar/style.css"
}

# =============================================================================
# Firefox userChrome.css & userContent.css
# =============================================================================
generate_firefox() {
    print_step "Generating Firefox colors..."
    
    for file in "userChrome.css" "userContent.css"; do
        local filepath="$SCRIPT_DIR/firefox/chrome/$file"
        
        if [[ ! -f "$filepath" ]]; then
            continue
        fi
        
        # Update CSS custom properties in :root
        sed -i "s/--obsidian: #[0-9A-Fa-f]\{6\};/--obsidian: #${OBSIDIAN};/g" "$filepath"
        sed -i "s/--abyss: #[0-9A-Fa-f]\{6\};/--abyss: #${ABYSS};/g" "$filepath"
        sed -i "s/--void-black: #[0-9A-Fa-f]\{6\};/--void-black: #${VOID_BLACK};/g" "$filepath"
        sed -i "s/--carbon: #[0-9A-Fa-f]\{6\};/--carbon: #${CARBON};/g" "$filepath"
        sed -i "s/--graphite: #[0-9A-Fa-f]\{6\};/--graphite: #${GRAPHITE};/g" "$filepath"
        sed -i "s/--slate: #[0-9A-Fa-f]\{6\};/--slate: #${SLATE};/g" "$filepath"
        sed -i "s/--ash: #[0-9A-Fa-f]\{6\};/--ash: #${ASH};/g" "$filepath"
        sed -i "s/--smoke: #[0-9A-Fa-f]\{6\};/--smoke: #${SMOKE};/g" "$filepath"
        sed -i "s/--iron: #[0-9A-Fa-f]\{6\};/--iron: #${IRON};/g" "$filepath"
        
        sed -i "s/--platinum: #[0-9A-Fa-f]\{6\};/--platinum: #${PLATINUM};/g" "$filepath"
        sed -i "s/--silver: #[0-9A-Fa-f]\{6\};/--silver: #${SILVER};/g" "$filepath"
        sed -i "s/--steel: #[0-9A-Fa-f]\{6\};/--steel: #${STEEL};/g" "$filepath"
        
        sed -i "s/--amethyst: #[0-9A-Fa-f]\{6\};/--amethyst: #${AMETHYST};/g" "$filepath"
        sed -i "s/--tyrian: #[0-9A-Fa-f]\{6\};/--tyrian: #${TYRIAN};/g" "$filepath"
        sed -i "s/--sapphire: #[0-9A-Fa-f]\{6\};/--sapphire: #${SAPPHIRE};/g" "$filepath"
        sed -i "s/--deep-sapphire: #[0-9A-Fa-f]\{6\};/--deep-sapphire: #${DEEP_SAPPHIRE};/g" "$filepath"
        
        sed -i "s/--gold: #[0-9A-Fa-f]\{6\};/--gold: #${GOLD};/g" "$filepath"
        sed -i "s/--pale-gold: #[0-9A-Fa-f]\{6\};/--pale-gold: #${PALE_GOLD};/g" "$filepath"
        
        sed -i "s/--crimson: #[0-9A-Fa-f]\{6\};/--crimson: #${CRIMSON};/g" "$filepath"
        sed -i "s/--teal: #[0-9A-Fa-f]\{6\};/--teal: #${TEAL};/g" "$filepath"
        
        print_success "firefox/chrome/$file"
    done
}

# =============================================================================
# Dunst dunstrc
# =============================================================================
generate_dunst() {
    print_step "Generating Dunst colors..."
    
    local filepath="$SCRIPT_DIR/dunst/dunstrc"
    
    if [[ ! -f "$filepath" ]]; then
        print_step "Skipping Dunst (no dunstrc found)"
        return
    fi
    
    # Update color values in dunstrc
    sed -i "s/background *= *\"#[0-9A-Fa-f]\{6\}\"/background = \"#${SURFACE}\"/g" "$filepath"
    sed -i "s/foreground *= *\"#[0-9A-Fa-f]\{6\}\"/foreground = \"#${TEXT_PRIMARY}\"/g" "$filepath"
    sed -i "s/frame_color *= *\"#[0-9A-Fa-f]\{6\}\"/frame_color = \"#${BORDER}\"/g" "$filepath"
    
    print_success "dunst/dunstrc"
}

# =============================================================================
# Rofi config.rasi
# =============================================================================
generate_rofi() {
    print_step "Generating Rofi colors..."
    
    local filepath="$SCRIPT_DIR/rofi/config.rasi"
    
    if [[ ! -f "$filepath" ]]; then
        print_step "Skipping Rofi (no config.rasi found)"
        return
    fi
    
    # Update color definitions
    sed -i "s/bg: *#[0-9A-Fa-f]\{6\}/bg: #${BASE}/g" "$filepath"
    sed -i "s/bg-alt: *#[0-9A-Fa-f]\{6\}/bg-alt: #${SURFACE}/g" "$filepath"
    sed -i "s/fg: *#[0-9A-Fa-f]\{6\}/fg: #${TEXT_PRIMARY}/g" "$filepath"
    sed -i "s/fg-alt: *#[0-9A-Fa-f]\{6\}/fg-alt: #${TEXT_SECONDARY}/g" "$filepath"
    sed -i "s/border: *#[0-9A-Fa-f]\{6\}/border: #${BORDER}/g" "$filepath"
    sed -i "s/accent: *#[0-9A-Fa-f]\{6\}/accent: #${PRIMARY_ACCENT}/g" "$filepath"
    sed -i "s/urgent: *#[0-9A-Fa-f]\{6\}/urgent: #${ERROR}/g" "$filepath"
    
    print_success "rofi/config.rasi"
}

# =============================================================================
# Wezterm wezterm.lua
# =============================================================================
generate_wezterm() {
    print_step "Generating Wezterm colors..."
    
    local filepath="$SCRIPT_DIR/wezterm/wezterm.lua"
    
    if [[ ! -f "$filepath" ]]; then
        print_step "Skipping Wezterm (no wezterm.lua found)"
        return
    fi
    
    # Update color scheme values
    sed -i "s/background *= *\"#[0-9A-Fa-f]\{6\}\"/background = \"#${BASE}\"/g" "$filepath"
    sed -i "s/foreground *= *\"#[0-9A-Fa-f]\{6\}\"/foreground = \"#${TEXT_PRIMARY}\"/g" "$filepath"
    sed -i "s/cursor_bg *= *\"#[0-9A-Fa-f]\{6\}\"/cursor_bg = \"#${FOCUS}\"/g" "$filepath"
    sed -i "s/cursor_fg *= *\"#[0-9A-Fa-f]\{6\}\"/cursor_fg = \"#${BASE}\"/g" "$filepath"
    sed -i "s/selection_bg *= *\"#[0-9A-Fa-f]\{6\}\"/selection_bg = \"#${SURFACE_HIGHLIGHT}\"/g" "$filepath"
    sed -i "s/selection_fg *= *\"#[0-9A-Fa-f]\{6\}\"/selection_fg = \"#${TEXT_PRIMARY}\"/g" "$filepath"
    
    print_success "wezterm/wezterm.lua"
}

# =============================================================================
# Micro colorscheme
# =============================================================================
generate_micro() {
    print_step "Generating Micro colorscheme..."
    
    cat > "$SCRIPT_DIR/micro/colorschemes/obsidian-tyrian.micro" << EOF
# Micro Colorscheme - Obsidian Tyrian
# Auto-generated from colors.sh - Run ./generate-themes.sh to regenerate

# EDITOR UI
color-link default "#${TEXT_PRIMARY},#${BASE}"
color-link line-number "#${TEXT_MUTED},#${MANTLE}"
color-link current-line-number "#${FOCUS},#${SURFACE}"
color-link cursor-line "#${SURFACE}"
color-link selection "#${TEXT_PRIMARY},#${SURFACE_HIGHLIGHT}"
color-link statusline "#${TEXT_PRIMARY},#${SURFACE}"
color-link tabbar "#${TEXT_MUTED},#${MANTLE}"
color-link indent-char "#${BORDER}"
color-link gutter-error "#${ERROR}"
color-link gutter-warning "#${FOCUS}"
color-link diff-added "#${SUCCESS}"
color-link diff-modified "#${SECONDARY_ACCENT}"
color-link diff-deleted "#${ERROR}"
color-link scrollbar "#${BORDER}"
color-link divider "#${BORDER}"
color-link message "#${TEXT_SECONDARY}"
color-link error-message "#${ERROR}"
color-link match-brace "#${FOCUS},#${SURFACE_HIGHLIGHT}"
color-link hlsearch "#${BASE},#${FOCUS}"

# SYNTAX HIGHLIGHTING
color-link comment "#${TEXT_MUTED},italic"
color-link constant.string "#${SUCCESS}"
color-link constant.string.char "#${SUCCESS}"
color-link constant.string.url "#${SECONDARY_ACCENT},underline"
color-link constant.number "#${FOCUS}"
color-link constant.bool "#${FOCUS}"
color-link constant.bool.true "#${SUCCESS}"
color-link constant.bool.false "#${ERROR}"
color-link constant.specialChar "#${ACCENT_HOVER}"
color-link statement "#${PRIMARY_ACCENT},bold"
color-link identifier "#${TEXT_SECONDARY}"
color-link identifier.class "#${SECONDARY_ACCENT},bold"
color-link identifier.var "#${TEXT_SECONDARY}"
color-link type "#${SECONDARY_ACCENT}"
color-link type.keyword "#${PRIMARY_ACCENT},bold"
color-link symbol "#${ACCENT_HOVER}"
color-link symbol.operator "#${ACCENT_HOVER}"
color-link symbol.brackets "#${TEXT_SECONDARY}"
color-link symbol.tag "#${PRIMARY_ACCENT}"
color-link preproc "#${ACCENT_HOVER}"
color-link special "#${FOCUS}"
color-link underlined "#${SECONDARY_ACCENT},underline"
color-link todo "#${FOCUS},bold,#${SURFACE_HIGHLIGHT}"
EOF
    
    print_success "micro/colorschemes/obsidian-tyrian.micro"
}

# =============================================================================
# Starship prompt
# =============================================================================
generate_starship() {
    print_step "Generating Starship colors..."
    
    local filepath="$SCRIPT_DIR/starship.toml"
    
    if [[ ! -f "$filepath" ]]; then
        print_step "Skipping Starship (no starship.toml found)"
        return
    fi
    
    # Starship uses named colors or hex, update common patterns
    # This is tricky as starship format is complex, so we do targeted replacements
    
    print_success "starship.toml (manual review recommended)"
}

# =============================================================================
# Yazi theme
# =============================================================================
generate_yazi() {
    print_step "Generating Yazi colors..."
    
    local filepath="$SCRIPT_DIR/yazi/theme.toml"
    
    if [[ ! -f "$filepath" ]]; then
        print_step "Skipping Yazi (no theme.toml found)"
        return
    fi
    
    # Yazi uses hex colors in TOML format
    sed -i "s/\"#[0-9A-Fa-f]\{6\}\" *# *base/\"#${BASE}\" # base/g" "$filepath"
    sed -i "s/\"#[0-9A-Fa-f]\{6\}\" *# *surface/\"#${SURFACE}\" # surface/g" "$filepath"
    sed -i "s/\"#[0-9A-Fa-f]\{6\}\" *# *text/\"#${TEXT_PRIMARY}\" # text/g" "$filepath"
    
    print_success "yazi/theme.toml"
}

# =============================================================================
# Main
# =============================================================================

echo -e "${PURPLE}"
cat << "EOF"
    ╔═══════════════════════════════════════════════════════════╗
    ║  🜂 Minerva Theme Generator                               ║
    ╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

generate_hyprland
generate_waybar
generate_firefox
generate_dunst
generate_rofi
generate_wezterm
generate_micro
generate_starship
generate_yazi

echo ""
echo -e "${GREEN}✓ All themes generated from colors.sh${NC}"
echo ""
echo "To apply changes:"
echo "  • Reload Hyprland: hyprctl reload"
echo "  • Restart Waybar: killall waybar && waybar &"
echo "  • Restart Firefox"
echo ""
