#!/usr/bin/env bash

# Copyright (C) 2021 6a6f6a6f <jonas.uliana@passwd.com.br>

# Project:     mobile-offsec
# Repository:  https://github.com/BizarreNULL/mobile-offsec
# License:     WTFPL
# Description: Install .CRT cert on AVD as system authority

ADB_DEVICE="emulator-5554"

wget -q "https://raw.githubusercontent.com/6a6f6a6f/mobile-offsec/main/certificates/burp_suite_default.crt" || true
CERTIFICATE_PATH="./burp_suite_default.crt"

if [ "$(adb -s "$ADB_DEVICE" shell getprop ro.build.version.sdk)" != "28" ];then
    echo "[!] AVD image must be Android 9!"
    exit 1
fi

FILENAME=$(openssl x509 -in "$CERTIFICATE_PATH" -hash -noout)
FILENAME=$FILENAME".0"

echo "[+] Generated certificate filename is $FILENAME"
echo "[+] Creating certificate file..."

openssl x509 -in "$CERTIFICATE_PATH" >> "$FILENAME"
openssl x509 -in "$CERTIFICATE_PATH"  -text -fingerprint -noout >> "$FILENAME"

echo "[+] Pushing to remote..."

adb root
sleep 5
adb disable-verity
adb remount
adb -s "$ADB_DEVICE" push "$FILENAME" /sdcard
adb -s "$ADB_DEVICE" shell "su 0 mv /sdcard/$FILENAME /system/etc/security/cacerts"
adb -s "$ADB_DEVICE" shell "su 0 chmod 644 /system/etc/security/cacerts/$FILENAME"
adb unroot
sleep 5
rm "$FILENAME" 2>/dev/null
rm "$CERTIFICATE_PATH" 2>/dev/null

echo "[+] Done, check if the cert is visible on settings."
