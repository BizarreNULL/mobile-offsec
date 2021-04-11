$CERTIFICATE_PATH = "./burp_suite_default.crt"
$ADB_DEVICE = "emulator-5554"

if (Get-Item -Path $CERTIFICATE_PATH -ErrorAction Ignore) {
    Remove-Item $CERTIFICATE_PATH
}

Write-Host "Downloading certificate from github.com/6a6f6a6f/mobile-offsec..."
Invoke-WebRequest "https://raw.githubusercontent.com/6a6f6a6f/mobile-offsec/main/certificates/burp_suite_default.crt" -OutFile $CERTIFICATE_PATH

if (adb -s $ADB_DEVICE shell getprop ro.build.version.sdk != "28") {
    Write-Error "Invalid remote ABI!"
    Exit 1
}

$FILENAME = $(openssl x509 -in "$CERTIFICATE_PATH" -hash -noout)
$FILENAME = $FILENAME+".0"

openssl x509 -in "$CERTIFICATE_PATH" >> "$FILENAME"
openssl x509 -in "$CERTIFICATE_PATH"  -text -fingerprint -noout >> "$FILENAME"

Write-Host "Generated certificate filename is $FILENAME"
Write-Host "Starting adb-server as root..."
adb root
Write-Host "Sleeping for a while..."
Start-Sleep 10
adb disable-verity
adb remount
adb -s "$ADB_DEVICE" push "$FILENAME" /sdcard
adb -s "$ADB_DEVICE" shell "su 0 mv /sdcard/$FILENAME /system/etc/security/cacerts"
adb -s "$ADB_DEVICE" shell "su 0 chmod 644 /system/etc/security/cacerts/$FILENAME"
Write-Host "Unrooting adb-server..."
adb unroot
Start-Sleep 5

Remove-Item $CERTIFICATE_PATH
Remove-Item $FILENAME

Write-Host "Done, check if the cert is visible on settings."
