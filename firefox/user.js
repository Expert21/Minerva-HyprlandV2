// =============================================================================
// Firefox user.js - Obsidian · Sapphire · Tyrian Configuration
// =============================================================================
//
// Installation:
// 1. Find your Firefox profile: Menu → Help → More Troubleshooting Info
//    Or navigate to: about:profiles → "Root Directory"
// 2. Copy this file (user.js) to your profile root directory
// 3. Restart Firefox
//
// Note: This file sets preferences on every Firefox startup.
// Changes made in about:config will be overwritten.
// =============================================================================

// -----------------------------------------------------------------------------
// Enable Custom CSS (Required for userChrome/userContent)
// -----------------------------------------------------------------------------
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Enable hardware acceleration for better performance
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);

// -----------------------------------------------------------------------------
// UI and Appearance
// -----------------------------------------------------------------------------
// Dark theme by default
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.theme.content-theme", 0);
user_pref("browser.theme.toolbar-theme", 0);

// Enable proton UI refinements
user_pref("browser.proton.enabled", true);

// Compact density for cleaner look
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);

// Smoother scrolling
user_pref("general.smoothScroll", true);
user_pref("general.smoothScroll.lines.durationMaxMS", 150);
user_pref("general.smoothScroll.lines.durationMinMS", 75);
user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 200);
user_pref("general.smoothScroll.mouseWheel.durationMinMS", 100);
user_pref("mousewheel.acceleration.factor", 10);
user_pref("mousewheel.acceleration.start", -1);

// Tab behavior
user_pref("browser.tabs.insertAfterCurrent", true);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.tabMinWidth", 100);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);

// Disable pocket (declutter UI)
user_pref("extensions.pocket.enabled", false);

// Disable sponsored content
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// Clean new tab page
user_pref("browser.newtabpage.activity-stream.feeds.topsites", true);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.topSitesRows", 2);

// Disable Firefox View button
user_pref("browser.tabs.firefox-view", false);

// -----------------------------------------------------------------------------
// URL Bar Behavior
// -----------------------------------------------------------------------------
// Show full URLs
user_pref("browser.urlbar.trimURLs", false);

// Cleaner URL bar suggestions
user_pref("browser.urlbar.suggest.bookmark", true);
user_pref("browser.urlbar.suggest.history", true);
user_pref("browser.urlbar.suggest.openpage", true);
user_pref("browser.urlbar.suggest.searches", true);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.topsites", true);

// Fewer suggestions for cleaner dropdown
user_pref("browser.urlbar.maxRichResults", 8);

// -----------------------------------------------------------------------------
// Privacy & Security (Pentester-Friendly)
// -----------------------------------------------------------------------------
// Strict Enhanced Tracking Protection
user_pref("browser.contentblocking.category", "strict");

// Disable telemetry
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// HTTPS-Only mode
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

// DNS over HTTPS (can be disabled for pentesting)
user_pref("network.trr.mode", 2);

// Disable WebRTC leak (important for VPN/pentesting)
user_pref("media.peerconnection.enabled", false);
// If you need WebRTC for video calls, comment above and use these instead:
// user_pref("media.peerconnection.ice.default_address_only", true);
// user_pref("media.peerconnection.ice.no_host", true);

// Disable geolocation
user_pref("geo.enabled", false);

// Disable battery status API
user_pref("dom.battery.enabled", false);

// Fingerprint resistance (use with caution - may break some sites)
// user_pref("privacy.resistFingerprinting", true);

// Clear data on shutdown (optional - uncomment if desired)
// user_pref("privacy.sanitize.sanitizeOnShutdown", true);
// user_pref("privacy.clearOnShutdown.cache", true);
// user_pref("privacy.clearOnShutdown.cookies", false);
// user_pref("privacy.clearOnShutdown.downloads", true);
// user_pref("privacy.clearOnShutdown.formdata", true);
// user_pref("privacy.clearOnShutdown.history", false);
// user_pref("privacy.clearOnShutdown.sessions", false);

// -----------------------------------------------------------------------------
// Developer Tools (Pentesting)
// -----------------------------------------------------------------------------
// Dark devtools
user_pref("devtools.theme", "dark");

// Enable all devtools
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.debugger.prompt-connection", false);

// Network monitor settings
user_pref("devtools.netmonitor.persistlog", true);

// Show hidden preferences
user_pref("browser.aboutConfig.showWarning", false);

// Enable browser console command line
user_pref("devtools.browserconsole.contentMessages", true);

// -----------------------------------------------------------------------------
// Performance
// -----------------------------------------------------------------------------
// Enable multi-process
user_pref("browser.tabs.remote.autostart", true);

// Session restore optimization
user_pref("browser.sessionstore.interval", 60000);

// Disable prefetch (saves bandwidth, better for pentesting)
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.predictor.enabled", false);

// Disable speculative connections
user_pref("network.http.speculative-parallel-limit", 0);

// -----------------------------------------------------------------------------
// Downloads
// -----------------------------------------------------------------------------
// Always ask where to save
user_pref("browser.download.useDownloadDir", false);

// Show download panel on complete
user_pref("browser.download.alwaysOpenPanel", false);

// -----------------------------------------------------------------------------
// Miscellaneous
// -----------------------------------------------------------------------------
// Disable fullscreen warning
user_pref("full-screen-api.warning.delay", 0);
user_pref("full-screen-api.warning.timeout", 0);

// Disable reader mode button
user_pref("reader.parse-on-load.enabled", false);

// Disable default browser check
user_pref("browser.shell.checkDefaultBrowser", false);

// Disable "What's new" page after updates
user_pref("browser.startup.homepage_override.mstone", "ignore");

// Middle-click paste URL and go
user_pref("middlemouse.contentLoadURL", false);

// Spell check in all text fields
user_pref("layout.spellcheckDefault", 2);

// Disable autoplay
user_pref("media.autoplay.default", 5);
user_pref("media.autoplay.blocking_policy", 2);
