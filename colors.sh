#!/usr/bin/env bash
# =============================================================================
# 🜂 Minerva Color Palette - Master Color Definitions
# Obsidian · Sapphire · Tyrian
# =============================================================================
#
# This is the SINGLE SOURCE OF TRUTH for all colors in the rice.
# Edit colors here, then run ./generate-themes.sh to update all configs.
#
# Usage: source this file in bash scripts
#   source colors.sh
#   echo $OBSIDIAN
#
# =============================================================================

# -----------------------------------------------------------------------------
# Core Neutrals
# -----------------------------------------------------------------------------
OBSIDIAN="1B1B1B"      # Base / Desktop
ABYSS="161616"         # Mantle
VOID_BLACK="0E0E0E"    # Crust / Shadow
CARBON="202020"        # Surface (Panels)
GRAPHITE="2A2A2A"      # Surface Elevated
SLATE="353535"         # Surface Highlight
ASH="474747"           # Border / Divider
SMOKE="5A5A5A"         # Overlay / Inactive
IRON="7E7E7E"          # Overlay Strong

# -----------------------------------------------------------------------------
# Text Colors
# -----------------------------------------------------------------------------
PLATINUM="E5E4E2"      # Primary Text
SILVER="C6C6C6"        # Secondary Text
STEEL="919191"         # Muted / Disabled

# -----------------------------------------------------------------------------
# Primary Accents
# -----------------------------------------------------------------------------
AMETHYST="550255"      # Primary Accent
TYRIAN="791B4D"        # Accent Hover
SAPPHIRE="0F52BA"      # Secondary Accent
DEEP_SAPPHIRE="0B3F91" # Accent Soft

# -----------------------------------------------------------------------------
# Highlights & Focus
# -----------------------------------------------------------------------------
GOLD="F7E7CE"          # Focus / Selection
PALE_GOLD="EED9B7"     # Active Glow

# -----------------------------------------------------------------------------
# Semantic
# -----------------------------------------------------------------------------
CRIMSON="8B2F3A"       # Error
TEAL="2F6F6B"          # Success

# =============================================================================
# Aliases (Semantic Names → Color Values)
# =============================================================================
# These map role names to actual colors for easier theming

# Base colors
BASE="$OBSIDIAN"
MANTLE="$ABYSS"
CRUST="$VOID_BLACK"
SURFACE="$CARBON"
SURFACE_ELEVATED="$GRAPHITE"
SURFACE_HIGHLIGHT="$SLATE"
BORDER="$ASH"
OVERLAY="$SMOKE"
OVERLAY_STRONG="$IRON"

# Text
TEXT_PRIMARY="$PLATINUM"
TEXT_SECONDARY="$SILVER"
TEXT_MUTED="$STEEL"

# Accents
PRIMARY_ACCENT="$AMETHYST"
ACCENT_HOVER="$TYRIAN"
SECONDARY_ACCENT="$SAPPHIRE"
ACCENT_SOFT="$DEEP_SAPPHIRE"

# Highlights
FOCUS="$GOLD"
ACTIVE_GLOW="$PALE_GOLD"

# Semantic
ERROR="$CRIMSON"
SUCCESS="$TEAL"
