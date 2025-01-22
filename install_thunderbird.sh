#!/bin/bash
#Init

myloc=$(dirname "$(realpath $0)")

sudo apt purge -y thunderbird*
sudo \rm -f /usr/bin/thunderbird
sudo \rm -Rf /usr/lib64/thunderbird
sudo \rm -Rf /usr/lib64/thunderbird-addons
sudo \rm -Rf /opt/thunderbird
#sudo \rm -Rf ~/.thunderbird
sudo \rm ~/ThunderbirdSetup.tar.bz2 2> /dev/null

wget -O ~/ThunderbirdSetup.tar.bz2 "https://download.mozilla.org/?product=thunderbird-esr-latest&os=linux64&lang=fr"

sudo tar xjf ~/ThunderbirdSetup.tar.bz2 -C /usr/lib64/

sudo ln -s /usr/lib64/thunderbird/thunderbird /usr/bin/thunderbird

sudo \rm /usr/lib64/thunderbird/defaults/pref/autoconfig.js 2> /dev/null
sudo mkdir -p /usr/lib64/thunderbird/defaults/pref/ 2> /dev/null
sudo tee /usr/lib64/thunderbird/defaults/pref/autoconfig.js >/dev/null <<'EOF'
//
pref("general.config.sandbox_enabled", false);
pref("general.config.filename", "thunderbird.cfg");
pref("general.config.obscure_value", 0);
EOF

sudo \rm /usr/lib64/thunderbird/thunderbird.cfg 2> /dev/null
sudo tee /usr/lib64/thunderbird/thunderbird.cfg >/dev/null <<'EOF'
//the first line is always a comment
pref("network.trr.mode", 3);
pref("network.trr.uri", "https://dns.adguard.com/dns-query");
pref("network.trr.custom_uri", "https://dns.adguard.com/dns-query");
pref("network.trr.bootstrapAddress", "1.1.1.2");
pref("network.trr.default_provider_uri", "https://dns.adguard.com/dns-query");
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
EOF

sudo \rm /usr/lib64/thunderbird/distribution/policies.json 2> /dev/null
sudo mkdir -p /usr/lib64/thunderbird/distribution 2> /dev/null
#about:memory -> measure
sudo tee /usr/lib64/thunderbird/distribution/policies.json >/dev/null <<'EOF'
{
  "policies": {
    "ExtensionSettings": {
      "cardbook@vigneau.philippe": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/thunderbird/downloads/latest/cardbook/latest.xpi"
      },
      "{a62ef8ec-5fdc-40c2-873c-223b8a6925cc}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/thunderbird/downloads/latest/provider-for-google-calendar/latest.xpi"
      },
      "tbsync@jobisoft.de": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/thunderbird/downloads/latest/tbsync/latest.xpi"
      },
      "AutoAddressCleaner-T@Toshi_": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/thunderbird/downloads/latest/auto-address-cleaner-t/latest.xpi"
      },
      "shrunked@mllr.pl": {
        "installation_mode": "normal_installed",
        "install_url": "https://github.com/memeller/shrunked/releases/download/v5.8.2/shrunked_image_resizer-5.8.2.xpi"
      },
      "uBlock0@raymondhill.net": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/thunderbird/downloads/latest/ublock-origin/latest.xpi"
      },
      "googleCalendar@weptun.de": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/google-calendar-plugin/platform:2/latest.xpi"
      },
      "thunderkeepplus@gmail.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/google-keep-tab/platform:2/latest.xpi"
      },
      "@dmrhn.googlecalendar.qa": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/google-calendar-quick-access/platform:2/latest.xpi"
      },
      "gkeep-thunder@tantely.fr": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/open-google-keep/platform:2/latest.xpi"
      },
      "gmessages_sigurd@dagestad.info": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/google-messages-tab/platform:2/latest.xpi"
      },
      "gmessages-thunder@tantely.fr": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/open-google-messages/platform:2/latest.xpi"
      },
      "maxime.dubreuil.ddf@gmail.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/google-contact-raccourci/platform:2/latest.xpi"
      },
      "{43ed69b5-6fb0-44d0-b200-d1b26d3fed39}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/proton-mail-toolbar-button/platform:2/latest.xpi"
      },
      "keiratreialdev@proton.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/gmail-tab/platform:2/latest.xpi"
      },
      "quick-spaces-thunder@tantely.fr": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.thunderbird.net/thunderbird/downloads/latest/quick-spaces/platform:2/latest.xpi"
      }
    }
  }
}
EOF

\rm ~/ThunderbirdSetup.tar.bz2

value=$(<$myloc/thunderbird.png.txt)
base64 -d <<< "$value" > /tmp/thunderbird.png
sudo mv /tmp/thunderbird.png /usr/lib64/thunderbird/

sudo setfacl -Rm u:$USER:rwx /usr/lib64/thunderbird/

sudo \rm /usr/share/applications/thunderbird-esr.desktop
sudo tee -a /usr/share/applications/thunderbird-esr.desktop >/dev/null <<'EOF'
[Desktop Entry]
Version=1.0
Name=Thunderbird
GenericName=Email
Comment=Send and Receive Email
Exec=thunderbird %u
TryExec=thunderbird
Icon=/usr/lib64/thunderbird/thunderbird.png
Terminal=false
Type=Application
MimeType=message/rfc822;x-scheme-handler/mailto;
StartupNotify=true
Categories=Network;Email;
Name[cs]=Poštovní klient Thunderbird
Name[ca]=Client de correu Thunderbird
Name[fi]=Thunderbird-sähköposti
Name[fr]=Messagerie Thunderbird
Name[pl]=Klient poczty Thunderbird
Name[pt_BR]=Cliente de E-mail Thunderbird
Name[sv]=E-postklienten Thunderbird
Comment[ca]=Llegiu i escriviu correu
Comment[cs]=Čtení a psaní pošty
Comment[de]=Emails lesen und verfassen
Comment[fi]=Lue ja kirjoita sähköposteja
Comment[fr]=Lire et écrire des courriels
Comment[it]=Leggere e scrivere email
Comment[ja]=メールの読み書き
Comment[pl]=Czytanie i wysyłanie e-maili
Comment[pt_BR]=Ler e escrever suas mensagens
Comment[sv]=Läs och skriv e-post
X-Desktop-File-Install-Version=0.27
EOF
