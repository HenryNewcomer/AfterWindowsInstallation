﻿#Requires -RunAsAdministrator

# A list of packages to install via Chocolatey
$chocolateyPackages = @(
    "firefox",
    "7zip",
    "discord",
    "emacs", # Check version, though!
    "mingw",
    "llvm",
    "cmake",
    "vlc",
    "googledrive",
    "dropbox",
    "git.install",
    "autohotkey",
    "filezilla",
    "chrome",
    "virtualbox",
    "audacity",
    "rufus",
    "cpu-z",
    "windirstat",
    "ultrasearch",
    "steam",
    "krita",
    "hwinfo",
    "kindle",
    "vscode",
    "Winaero"
)

$setSystemEnvVars = @(
    "HOME $env:userprofile"
)
$addSystemPaths = @(
    ";C:\mingw\bin" # TODO Update to chocolatey location?
)

# TODO Stop the recursive nature of this
function henry-showSetupSteps {
    $setupSteps = [Management.Automation.Host.ChoiceDescription[]] @(
        New-Object Management.Automation.Host.ChoiceDescription("&Ubuntu","Ubuntu download")
        New-Object Management.Automation.Host.ChoiceDescription("&Chocolatey (Install)","Basic Chocolatey installation.")
        New-Object Management.Automation.Host.ChoiceDescription("Chocolatey (&Packages)","Install Chocolatey packages.")
        New-Object Management.Automation.Host.ChoiceDescription("Setup &extra system vars","Programs like Emacs can make use of custom PATH variables.")
        New-Object Management.Automation.Host.ChoiceDescription("&Quit","Abort this script.")
    )
    $global:selection = $Host.UI.PromptForChoice("Auto-Setup Step Selection","Which step would you like to proceed with?",$setupSteps,4)

    if ($selection -eq 0) {
        echo "Attempting to download Ubuntu 18.04"
        Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
        .\Ubuntu.appx
        henry-showSetupSteps
    } elseif ($selection -eq 1) {
        echo "Attempting to install Chocolatey"
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        henry-showSetupSteps
    } elseif ($selection -eq 2) {
        echo "Attempting to install Chocolatey packages"
        # TODO Save a txt/cache of packages that were (or weren't?) installed
        foreach($package in $chocolateyPackages) {
            choco install $package -y
	        # FIXME Not finding package properly &
            # FIXME All packages trigger echo
            #if (Get-Package $package | Install-Package) {
            #    continue;
            #} else {
            #    echo "$package wasn't installed!"
            #    pause
            #}
        }
        henry-showSetupSteps
    } elseif ($selection -eq 3) {
        echo "Adding new user variables"
        foreach($update in $setSystemEnvVars) {
            echo "Running command: setx $update ..."
            setx $update
        }
        echo "Adding paths to user environments"
        foreach($addedValue in $addSystemPaths) {
            echo "Running command: $env:Path += $addedValue ..."
            $env:Path += $addedValue
        }
        # TODO Remove all of these (and move one), and just use a var to track if script should keep running or quit
        henry-showSetupSteps
    }
    # else quiting...
}

# -----------------

echo "Automated setup for new Windows installation will start in a few seconds..."
Start-Sleep 4
henry-showSetupSteps

echo "Quitting..."
Start-Sleep 4
