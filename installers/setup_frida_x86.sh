#!/usr/bin/env bash

# Copyright (C) 2020 6a6f6a6f <jonas.uliana@passwd.com.br>

# Project:     mobile-offsec
# Repository:  https://github.com/6a6f6a6f/mobile-offsec
# License:     WTFPL
# Description: Install frida-server on remove

FRIDA_LAST_RELEASE_URL="https://github.com/frida/frida/releases/download/14.2.14/frida-server-14.2.14-android-x86.xz"
ARCH=$(adb shell getprop ro.product.cpu.abi)
FRIDA_PID=$(adb shell pgrep frida)

echo "[+] Checking current device architecture..."

if [ $ARCH != "x86" ]
then
   echo "[!] Invalid device architecture!"
   echo "[!] This script target only x86 devices."

   exit -1
fi

echo "[+] Downloading frida-server..."
wget $FRIDA_LAST_RELEASE_URL -O /tmp/frida.xz >/dev/null 2>&1
unxz /tmp/frida.xz

if [ ! -z "$FRIDA_PID" ] 
then
   echo "[+] Killing any frida-server instances on Android device..."
   adb shell "su 0 kill $FRIDA_PID"
fi

echo "[+] Pushing binaries to remote..."
adb push /tmp/frida /data/local/tmp
echo "[+] Granting execute privileges..."
adb shell "su 0 chmod 077 /data/local/tmp/frida"
echo "[+] Starting frida-server"
adb shell "su 0 ./data/local/tmp/frida"
