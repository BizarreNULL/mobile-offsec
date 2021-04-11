<p align="center">
<a href="https://github.com/6a6f6a6f/mobile-offsec/">
  <img src="./resources/logo.png" width="350" />
</a>
</p>
<h1 align="center">
  Mobile Application Penetration Testing
</h1>

<p align="center">
  My personal <i>repo</i> to automate some stuffs for pentesting
  <br/><br/>
  <a href="http://www.wtfpl.net/txt/copying/">
    <img alt="WTFPL License" src="https://img.shields.io/github/license/6a6f6a6f/mobile-offsec" />
  </a>
  <img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/6a6f6a6f/mobile-offsec">
</p>

## Why?

A lot of things in the mobile application penetration testing - especially on generic stuff, like install certificates on specifics API levels or extract JNI calls - can be easily automated, so I created this shitty to help you and me to stop doing manual kinds of stuff every time on a lab.

This repository is focused on Android and iOS, but not only the applications itself, but also aim to payment terminals penetration testing or any kind of "mobile" device that can be pwned.

> Why use a bee as a logo? Well, Why not?



## One-liners

Install default Burp Suite (Professional and Community) certificate on remote AVD instance (considering remote device as `emulator-5554`) (**Linux and macOS**):

```sh
bash <(curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/6a6f6a6f/mobile-offsec/main/installers/avd_setup.sh)
```



Install default Burp Suite (Professional and Community) certificate on remote AVD instance (considering remote device as `emulator-5554`) (**Windows (or system with PowerShell Core**):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/6a6f6a6f/mobile-offsec/main/installers/Install-Burp-Android.ps1'))
```



Start last `frida-server` version for x86 on remote AVD instance (**Linux and macOS**):

```sh
bash <(curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/6a6f6a6f/mobile-offsec/main/installers/setup_frida_x86.sh)
```



## Directory Structure

Actually I don't have this at this time, but I think is self-explanatory the name of every folder, if you have need a help to understood my codes, feel free to shot a [issue](https://github.com/6a6f6a6f/mobile-offsec/issues).



## Licenses

[Mobile Application Penetration Testing](https://github.com/6a6f6a6f/mobile-offsec/mobile-offsec) project logo and all other *repo* icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com.</a>