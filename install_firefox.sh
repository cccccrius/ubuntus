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

wget -O ~/FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=fr"

sudo tar xjf ~/FirefoxSetup.tar.bz2 -C /usr/lib64/

sudo ln -s /usr/lib64/firefox/firefox /usr/bin/firefox

sudo \rm /usr/lib64/firefox/defaults/pref/autoconfig.js 2> /dev/null
sudo mkdir -p /usr/lib64/firefox/defaults/pref/ 2> /dev/null
sudo tee /usr/lib64/firefox/defaults/pref/autoconfig.js >/dev/null <<'EOF'
//
pref("general.config.sandbox_enabled", false);
pref("general.config.filename", "firefox.cfg");
pref("general.config.obscure_value", 0);
EOF

sudo \rm /usr/lib64/firefox/firefox.cfg 2> /dev/null
sudo tee /usr/lib64/firefox/firefox.cfg >/dev/null <<'EOF'
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
EOF

sudo \rm /usr/lib64/firefox/distribution/policies.json 2> /dev/null
sudo mkdir -p /usr/lib64/firefox/distribution 2> /dev/null
#about:memory -> measure
sudo tee /usr/lib64/firefox/distribution/policies.json >/dev/null <<'EOF'
{
  "policies": {
    "ExtensionSettings": {
      "uBlock0@raymondhill.net": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      },
      "{66E978CD-981F-47DF-AC42-E3CF417C1467}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/new-tab-homepage/latest.xpi"
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
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/4064884/clearurls-1.26.1.xpi"
      },
      "dont-track-me-google@robwu.nl": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/4132891/dont_track_me_google1-4.28.xpi"
      },
      "gmailellcheckersimple@durasoft": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/4273216/gmail_checker_simple-1.1resigned1.xpi"
      },
      "{abea9bb3-7bd0-48bc-88b1-39f0560744d6}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/4302353/google_search_fixer_refreshed-2.0.xpi"
      },
      "{00000f2a-7cde-4f20-83ed-434fcb420d71}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/3547888/imagus-0.9.8.74.xpi"
      },
      "support@netflux.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/4335048/netflux-1.0.9.xpi"
      },
      "plasma-browser-integration@kde.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/4298512/plasma_integration-1.9.1.xpi"
      },
      "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/file/4098688/user_agent_string_switcher-0.5.0.xpi"
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
