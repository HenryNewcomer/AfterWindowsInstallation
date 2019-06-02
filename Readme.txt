
/////////////////////
Pre-config setup:
/////////////////////

// PART ONE

1) Open PowerShell **as Administrator**

2) In order to run the subsystem, enter:
Set-ExecutionPolicy Bypass -Scope Process
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

3) Restart the computer if needed

// PART TWO

4) Open PowerShell **as Administrator**

5) Move to this project's root directory

6) Run the following two commands:
Set-ExecutionPolicy Bypass -Scope Process
.\init.ps1

# Note: You can check the current policy via: Get-ExecutionPolicy