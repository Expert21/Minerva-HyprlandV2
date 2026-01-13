# Firefox - Obsidian · Sapphire · Tyrian Theme

A complete Firefox theming configuration matching the Minerva rice aesthetic.

## 🎨 Features

- **Complete UI Theme**: Custom styling for tabs, toolbar, URL bar, menus, sidebar, and more
- **Internal Pages**: Themed `about:newtab`, `about:preferences`, `about:addons`, and error pages
- **Pentester-Friendly**: WebRTC disabled, telemetry off, HTTPS-only mode
- **Performance**: Hardware acceleration, smooth scrolling, optimized settings
- **Dark DevTools**: Pre-configured dark developer tools

## 📁 Files

| File | Description |
|------|-------------|
| `chrome/userChrome.css` | Styles the browser UI (tabs, toolbar, menus) |
| `chrome/userContent.css` | Styles internal Firefox pages |
| `user.js` | Firefox preferences (enables CSS, privacy, performance) |

## 🚀 Installation

### 1. Find Your Firefox Profile

```bash
# Option A: Open Firefox and navigate to
about:profiles

# Option B: Find via terminal
ls ~/.mozilla/firefox/*.default-release/
```

### 2. Install the Files

```bash
# Set your profile path
PROFILE=~/.mozilla/firefox/YOUR_PROFILE.default-release

# Create chrome directory
mkdir -p "$PROFILE/chrome"

# Copy files
cp chrome/userChrome.css "$PROFILE/chrome/"
cp chrome/userContent.css "$PROFILE/chrome/"
cp user.js "$PROFILE/"
```

### 3. Restart Firefox

Close and reopen Firefox completely. The theme will be applied.

## 🔧 Quick Deploy Script

```bash
#!/bin/bash
# deploy-firefox-theme.sh

PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -name "*.default-release" -type d | head -1)

if [ -z "$PROFILE_DIR" ]; then
    echo "❌ No Firefox profile found"
    exit 1
fi

echo "📂 Profile: $PROFILE_DIR"

mkdir -p "$PROFILE_DIR/chrome"
cp chrome/userChrome.css "$PROFILE_DIR/chrome/"
cp chrome/userContent.css "$PROFILE_DIR/chrome/"
cp user.js "$PROFILE_DIR/"

echo "✅ Theme installed! Restart Firefox."
```

## 🎨 Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Obsidian | `#1B1B1B` | Base background |
| Carbon | `#202020` | Panels/toolbar |
| Graphite | `#2A2A2A` | Inputs/elevated surfaces |
| Slate | `#353535` | Hover states |
| Platinum | `#E5E4E2` | Primary text |
| Silver | `#C6C6C6` | Secondary text |
| Amethyst | `#550255` | Primary accent (active tabs) |
| Tyrian | `#791B4D` | Accent hover |
| Sapphire | `#0F52BA` | Secondary accent (links, buttons) |
| Gold | `#F7E7CE` | Focus/highlights |
| Teal | `#2F6F6B` | Success/secure |
| Crimson | `#8B2F3A` | Error/close |

## ⚠️ Pentesting Notes

The `user.js` includes privacy-hardening settings:

- **WebRTC disabled**: Prevents IP leaks behind VPN
- **Telemetry disabled**: No data sent to Mozilla  
- **HTTPS-Only**: Forces secure connections
- **Prefetch disabled**: No speculative requests
- **Geolocation disabled**: Location API blocked

To **temporarily enable WebRTC** (for video calls):
1. Go to `about:config`
2. Set `media.peerconnection.enabled` to `true`

## 🔄 Updating

After updating Firefox, the `user.js` settings persist. CSS files are safe.

If themes break after a major Firefox update, check the [Firefox Source Docs](https://firefox-source-docs.mozilla.org/) for updated CSS selectors.

## 📎 Recommended Extensions

- **uBlock Origin** - Ad blocking
- **FoxyProxy** - Proxy management for pentesting
- **Cookie Editor** - Cookie manipulation
- **Wappalyzer** - Tech stack detection
- **HackTools** - Pentesting web extension
