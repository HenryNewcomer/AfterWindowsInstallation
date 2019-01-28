# Linux subsystem
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Manually install Ubuntu from: https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6?rtc=1&activetab=pivot:overviewtab

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))