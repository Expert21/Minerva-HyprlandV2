# 🜂 Minerva — Obsidian · Sapphire · Tyrian

A luxurious dark Hyprland rice with royal purple, sapphire blue, and champagne gold accents.

![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-blue?style=flat-square)
![Arch Linux](https://img.shields.io/badge/Arch-Linux-1793D1?style=flat-square&logo=arch-linux)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

## Made for Arch Linux

## 🎨 Color Palette

| Role | Name | Hex |
|------|------|-----|
| Base | Obsidian | `#1B1B1B` |
| Mantle | Abyss | `#161616` |
| Surface | Carbon | `#202020` |
| Surface Elevated | Graphite | `#2A2A2A` |
| Border | Ash | `#474747` |
| Primary Text | Platinum | `#E5E4E2` |
| Secondary Text | Silver | `#C6C6C6` |
| Muted Text | Steel | `#919191` |
| Primary Accent | Imperial Amethyst | `#550255` |
| Accent Hover | Tyrian Rose | `#791B4D` |
| Secondary Accent | Sapphire | `#0F52BA` |
| Focus/Selection | Champagne Gold | `#F7E7CE` |
| Error | Muted Crimson | `#8B2F3A` |
| Success | Deep Teal | `#2F6F6B` |

## 📦 Tech Stack

| Component | Tool |
|-----------|------|
| **WM** | Hyprland |
| **Terminal** | Wezterm + Starship |
| **Shell** | zsh + oh-my-zsh |
| **File Manager** | Yazi |
| **Wallpaper** | swww |
| **Launcher** | Rofi-wayland |
| **Clipboard** | wl-clipboard + cliphist |
| **Auth Prompt** | polkit + polkit-gnome |
| **Screenshot** | hyprshot + swappy |
| **Font** | JetBrains Mono |
| **Idle** | Hypridle |
| **Lock Screen** | Hyprlock |
| **Bar** | Waybar |
| **Notifications** | Dunst |
| **Browser** | Firefox (themed) |
| **Editor** | Micro (themed) |

## 📁 Structure

```
Minerva-From-Scratch/
├── hypr/
│   ├── hyprland.conf          # Main entry point
│   ├── master.conf            # Primary settings (edit this!)
│   ├── hypridle.conf          # Idle behavior
│   ├── hyprlock.conf          # Lock screen config
│   ├── scheme/
│   │   └── colors.conf        # Color palette variables
│   └── hyprland/
│       ├── animations.conf    # Animation curves
│       ├── decoration.conf    # Borders, shadows, blur
│       ├── env.conf           # Environment variables
│       ├── execs.conf         # Startup applications
│       ├── general.conf       # Gaps, layout, colors
│       ├── gestures.conf      # Touchpad gestures
│       ├── input.conf         # Keyboard/mouse settings
│       ├── keybinds.conf      # All keybindings
│       ├── misc.conf          # Miscellaneous settings
│       └── rules.conf         # Window rules
├── waybar/
│   ├── config                 # Waybar modules
│   └── style.css              # Waybar theme
├── dunst/
│   └── dunstrc                # Notification styling
├── rofi/
│   └── config.rasi            # Launcher theme
├── wezterm/
│   └── wezterm.lua            # Terminal config
├── yazi/
│   ├── yazi.toml              # File manager settings
│   ├── keymap.toml            # Yazi keybindings
│   └── theme.toml             # Yazi colors
├── micro/
│   ├── settings.json          # Editor settings
│   └── colorschemes/
│       └── obsidian-tyrian.micro
├── firefox/
│   ├── chrome/
│   │   ├── userChrome.css     # Browser UI theme
│   │   └── userContent.css    # Internal pages theme
│   └── user.js                # Firefox preferences
├── starship.toml              # Prompt configuration
├── install.sh                 # Deployment script
└── README.md
```

## 🚀 Installation

### Prerequisites

Install the required packages:

```bash
# Core
sudo pacman -S hyprland hyprlock hypridle xdg-desktop-portal-hyprland

# Terminal & Shell
sudo pacman -S wezterm zsh starship

# Utilities
sudo pacman -S rofi-wayland waybar dunst swww yazi
sudo pacman -S wl-clipboard cliphist polkit polkit-gnome
sudo pacman -S hyprshot swappy grim slurp

# Fonts
sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd

# Optional: oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Optional: micro editor
sudo pacman -S micro
```

### Deploy Configuration

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/Minerva-From-Scratch.git
cd Minerva-From-Scratch

# Run the installer
chmod +x install.sh
./install.sh
```

The installer will:
1. Backup existing configs to `~/.config-backup-TIMESTAMP/`
2. Create symlinks from `~/.config/` to this repository
3. Deploy Firefox theme to your profile
4. Set up micro colorscheme

## ⚙️ Configuration

### Quick Edits

Most settings you'll want to change are in **`hypr/master.conf`**:
- Gaps and borders
- Default applications
- Monitor configuration
- Workspace settings

### Hyprlock & Hypridle

These are configured separately:
- `hypr/hyprlock.conf` — Lock screen appearance
- `hypr/hypridle.conf` — Timeout behaviors

### Colors

All colors are defined in `hypr/scheme/colors.conf` as Hyprland variables.
Other configs reference these colors for consistency.

## ⌨️ Keybindings

| Key | Action |
|-----|--------|
| `Super + Return` | Terminal (Wezterm) |
| `Super + D` | Launcher (Rofi) |
| `Super + Q` | Close window |
| `Super + M` | Exit Hyprland |
| `Super + E` | File manager (Yazi) |
| `Super + V` | Clipboard history |
| `Super + L` | Lock screen |
| `Print` | Screenshot (selection) |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move to workspace |

See `hypr/hyprland/keybinds.conf` for the complete list.

## 🦊 Firefox Theme

The Firefox configuration includes:
- **userChrome.css** — Dark themed browser UI
- **userContent.css** — Themed internal pages
- **user.js** — Privacy/security hardening (WebRTC disabled, telemetry off)

See `firefox/README.md` for manual installation.

## 🔧 Troubleshooting

### Waybar not showing
```bash
killall waybar && waybar &
```

### Hyprlock not working
Ensure `hypridle` is running:
```bash
systemctl --user status hypridle
# Or start manually
hypridle &
```

### Firefox theme not applying
1. Ensure `toolkit.legacyUserProfileCustomizations.stylesheets` is `true` in `about:config`
2. Verify the `chrome` folder is in your Firefox profile root

## 📜 License

MIT License — feel free to fork and customize!

---

*"From the void, elegance emerges."*
