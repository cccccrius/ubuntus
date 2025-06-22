#!/usr/bin/env bash

#####
# script to sign unsigned last installed kernel.
# preqs is openssl
# Crius 2025 - crius38@gmail.com
#####

###
# functions & vars
###

# function to generate openssl keys
function generation {

    \rm /tmp/openssl.cnf

    tee -a /tmp/openssl.cnf >/dev/null <<'EOF'
# This definition stops the following lines choking if HOME isn't
# defined.
HOME                    = .
RANDFILE                = $ENV::HOME/.rnd 
[ req ]
distinguished_name      = req_distinguished_name
x509_extensions         = v3
string_mask             = utf8only
prompt                  = no

[ req_distinguished_name ]
countryName             = YOUR_COUNTRY_CODE (ex: FR for France)
stateOrProvinceName     = YOUR_CITY
localityName            = YOUR_CITY
0.organizationName      = YOUR_NAME
commonName              = Secure Boot Signing
emailAddress            = YOUR_MAIL

[ v3 ]
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always,issuer
basicConstraints        = critical,CA:FALSE
extendedKeyUsage        = codeSigning,1.3.6.1.4.1.311.10.3.6
nsComment               = "OpenSSL Generated Certificate"
EOF

     openssl req -config /tmp/openssl.cnf \
        -new -x509 -newkey rsa:2048 \
        -nodes -days 36500 -outform DER \
        -keyout "/var/lib/shim-signed/mok/MOKKERNEL.priv" \
        -out "/var/lib/shim-signed/mok/MOKKERNEL.der"

}

# we use OS installation certificate to sign the new kernel for secure boot
MOKPATH=/var/lib/shim-signed/mok
MOKPRIV=$MOKPATH/MOKKERNEL.priv
MOKDER=$MOKPATH/MOKKERNEL.der
MOKPEM=$MOKPATH/MOKKERNEL.pem

# we find the last kernel version and files to sign
LASTKERNEL=$(ls -td /lib/modules/*/ | head -1) && LASTKERNEL=$(echo $LASTKERNEL| cut -d'/' -f 4)
KERNELFILE=/boot/vmlinuz-$LASTKERNEL
INITFILE=/boot/initrd.img-$LASTKERNEL
KERNELFILES=/boot/vmlinuz-$LASTKERNEL.signed
INITFILES=/boot/initrd.img-$LASTKERNEL.signed
KERNELFILESS=vmlinuz-$LASTKERNEL.signed
INITFILESS=initrd.img-$LASTKERNEL.signed
FILE=/tmp/openssl.cnf

###
# functions & vars - end
###

###
# script corpse
###

#checking openssl keys
if [ -f $MOKPRIV ]
then
    echo "$MOKPRIV exists."
else 
   sudo bash -c "$(declare -f generation); generation" && sudo echo "Generating openssl keys"
fi

# we create MOK.pem
if [ ! -f $MOKPEM ]; then
    sudo openssl x509 -in $MOKDER -inform DER -outform PEM -out $MOKPEM && sudo echo "$MOKPEM created"
else
    echo "$MOKPEM exists"
fi

# we import system key into bios
sudo mokutil --import $MOKDER

# we sign last kernel
if [ ! -f $KERNELFILE.signed ]; then
    sudo sbsign --key $MOKPRIV --cert $MOKPEM $KERNELFILE --output $KERNELFILES && sudo echo "$KERNELFILE signed as $KERNELFILES"
else
    echo "$KERNELFILES exists"
fi


# we create initfile for signed kernel
if [ ! -f $INITFILE.signed ]; then
    sudo cp $INITFILE $INITFILES && sudo echo "$INITFILE signed as $INITFILES"
else
    echo "$INITFILES exists"
fi

#rebuilding links
sudo unlink /boot/vmlinuz
sudo unlink /boot/initrd.img

sudo ln -s $KERNELFILESS /boot/vmlinuz
sudo ln -s $INITFILESS /boot/initrd.img

#removing temp file
if [ -f "$FILE" ]
then
    sudo \rm /tmp/openssl.cnf
fi

#rebuilding grub
sudo update-grub

ls -alFh /boot | grep signed
