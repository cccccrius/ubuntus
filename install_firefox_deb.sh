#!/bin/bash
#Init

myloc=$(dirname "$(realpath $0)")

sudo apt purge -y firefox*
sudo \rm -f /usr/bin/firefox
sudo \rm -Rf /usr/lib64/firefox
sudo \rm -Rf /usr/lib64/firefox-addons
sudo \rm -Rf /opt/firefox
#sudo \rm -Rf ~/.mozilla
sudo \rm ~/FirefoxSetup.tar.bz2 2> /dev/null

# on met les serveurs français pour apt
echo "deb http://fr.archive.ubuntu.com/ubuntu/ plucky main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu/ plucky-updates main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu/ plucky-backports main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu/ plucky-security main restricted universe multiverse" | sudo tee /etc/apt/sources.list

# on supprime firefox installé depuis le repo chinois
sudo apt purge -y firefox*

# on impoorte la clé du repo officiel mozilla
sudo wget https://packages.mozilla.org/apt/repo-signing-key.gpg -O  /etc/apt/keyrings/packages.mozilla.org.asc

# on crée le repo officiel mozilla
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list

# on autorise à installer firefox que depuis le repo mozilla
echo "Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000" | sudo tee /etc/apt/preferences.d/firefox-deb-nosnap

# mise à jour apt
sudo apt update

# on installe firefox:
sudo apt install -y firefox-l10n-fr

sudo \rm /usr/lib/firefox/defaults/pref/autoconfig.js 2> /dev/null
sudo mkdir -p /usr/lib/firefox/defaults/pref/ 2> /dev/null
sudo tee /usr/lib/firefox/defaults/pref/autoconfig.js >/dev/null <<'EOF'
//
pref("general.config.sandbox_enabled", false);
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF

sudo \rm /usr/lib/firefox/firefox.cfg 2> /dev/null
sudo tee /usr/lib/firefox/firefox.cfg >/dev/null <<'EOF'
//the first line is always a comment
pref("network.trr.mode", 3);
pref("network.trr.uri", "https://dns.nextdns.io/c8d79a");
pref("network.trr.custom_uri", "https://dns.nextdns.io/c8d79a");
pref("network.trr.bootstrapAddress", "45.90.28.181");
pref("network.trr.default_provider_uri", "https://dns.nextdns.io/c8d79a");
pref("extensions.autoDisableScopes", 0);
pref("browser.aboutConfig.showWarning", false);
pref("browser.startup.homepage", "https://www.google.fr");
pref("startup.homepage_welcome_url", "https://www.google.fr");
pref("startup.homepage_override_url", "https://www.google.fr");
pref("browser.shell.checkDefaultBrowser", false);
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
pref("app.update.silent", true);
pref("browser.messaging-system.whatsNewPanel.enabled", false);
pref("privacy.trackingprotection.enabled", true);
pref("privacy.firstparty.isolate", true);
pref("privacy.donottrackheader.enabled", true);
pref("privacy.globalprivacycontrol.enabled", true);
pref("privacy.globalprivacycontrol.functionality.enabled", true);
pref("toolkit.telemetry.archive.enabled", false);
pref("toolkit.telemetry.enabled", false);
pref("toolkit.telemetry.rejected", true);
pref("toolkit.telemetry.unified", false);
pref("toolkit.telemetry.unifiedIsOptIn", false);
pref("toolkit.telemetry.prompted", 2);
pref("toolkit.telemetry.rejected", true);
pref("datareporting.policy.dataSubmissionEnabled", false);
pref("datareporting.healthreport.service.enabled", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("app.shield.optoutstudies.enabled", false);
pref("browser.urlbar.suggest.pocket", false);
pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
pref("browser.newtabpage.activity-stream.system.showSponsored", false);
pref("browser.newtabpage.activity-stream.showSponsored", false);
pref("extensions.pocket.enabled", false);
pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
pref("network.dns.echconfig.enabled", true);
pref("network.dns.http3_echconfig.enabled", true);
pref("browser.toolbars.bookmarks.visibility", "always");
pref("media.ffmpeg.vaapi.enabled",true);
pref("media.ffvpx.enabled",false);
pref("media.rdd-vpx.enabled",false);
pref("media.navigator.mediadatadecoder_vpx_enabled",true);
pref("image.webp",false);
pref("browser.download.viewableInternally.typeWasRegistered.webp",false);
pref("drm",true);
pref("sidebar.visibility", "hide-sidebar");
pref("sidebar.revamp", false);
pref("signon.rememberSignons", false);
pref("browser.translations.automaticallyPopup", false);
pref("browser.startup.page", 3);
pref("browser.shell.checkDefaultBrowser", true);
EOF

sudo \rm /usr/lib/firefox/distribution/policies.json 2> /dev/null
sudo mkdir -p /usr/lib/firefox/distribution 2> /dev/null
#about:memory -> measure
sudo tee /usr/lib64/firefox/distribution/policies.json >/dev/null <<'EOF'
{
  "policies": {
    "ExtensionSettings": {
      "uBlock0@raymondhill.net": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      },
      "{26b743a8-b1b0-4b8c-a51e-0fc3797727a8}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-consent-dialog-remover/latest.xpi"
      },
      "DontFuckWithPaste@raim.ist": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi"
      },
      "jid1-MnnxcxisBPnSXQ@jetpack": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi"
      },
      "newtaboverride@agenedia.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi"
      },
      "pure-url@jetpack": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/pure-url/latest.xpi"
      },
      "gdpr@cavi.au.dk": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi"
      },
      "magnolia_limited_permissions@12.34": {
        "installation_mode": "normal_installed",
        "install_url": "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-3.8.8.0-custom.xpi"
      },
      "{74145f27-f039-47ce-a470-a662b129930a}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
      },
      "dont-track-me-google@robwu.nl": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/dont-track-me-google1/latest.xpi"
      },
      "gmailellcheckersimple@durasoft": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/gmail-checker-simple/latest.xpi"
      },
      "{abea9bb3-7bd0-48bc-88b1-39f0560744d6}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-search-fixer-refreshed/latest.xpi"
      },
      "{00000f2a-7cde-4f20-83ed-434fcb420d71}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi"
      },
      "support@netflux.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/netflux/latest.xpi"
      },
      "plasma-browser-integration@kde.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi"
      },
      "chrome-gnome-shell@gnome.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/gnome-shell-integration/latest.xpi"
      },
      "{7c73b62b-7ac7-4292-81a7-c15746af0972}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/google-search-display-icon/latest.xpi"
      },
      "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi"
      },
      "NetflixPrime@Autoskip.io": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/netflix-prime-auto-skip/latest.xpi"
      },
      "78272b6fa58f4a1abaac99321d503a20@proton.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi"
      }
    }
  }
}
EOF

\rm ~/FirefoxSetup.tar.bz2

value=$(<$myloc/firefox.png.txt)
base64 -d <<< "$value" > /tmp/firefox.png
sudo mv /tmp/firefox.png /usr/lib64/firefox/

sudo setfacl -Rm u:$USER:rwx /usr/lib64/firefox/

sudo \rm /usr/share/applications/firefox.desktop
sudo tee -a /usr/share/applications/firefox.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=Firefox Web Browser
Name[fr]=Navigateur Web Firefox
Comment=Browse the World Wide Web
Comment[fr]=Naviguer sur le Web
GenericName=Web Browser
GenericName[fr]=Navigateur Web
Keywords=Internet;WWW;Browser;Web;Explorer
Keywords[fr]=Internet;WWW;Browser;Web;Explorer;Fureteur;Surfer;Navigateur
Exec=firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/usr/lib64/firefox/firefox.png
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true
Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=Open a New Window
Name[fr]=Ouvrir une nouvelle fenêtre
Exec=firefox -new-window

[Desktop Action new-private-window]
Name=Open a New Private Window
Name[fr]=Ouvrir une nouvelle fenêtre de navigation privée
Exec=firefox -private-window
EOF
