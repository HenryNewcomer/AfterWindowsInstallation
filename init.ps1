#Requires -RunAsAdministrator

# A list of packages to install via Chocolatey
$chocolateyPackages = @(
    "firefox",
    "7zip",
    "emacs", # Check version
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
    "vscode"
)

# TODO Stop the recursive nature of this
function henry-showSetupSteps {
    $setupSteps = [Management.Automation.Host.ChoiceDescription[]] @(
        New-Object Management.Automation.Host.ChoiceDescription("&Ubuntu","Ubuntu download")
        New-Object Management.Automation.Host.ChoiceDescription("&Chocolatey (Install)","Basic Chocolatey installation.")
        New-Object Management.Automation.Host.ChoiceDescription("Chocolatey (&Packages)","Install Chocolatey packages.")
        New-Object Management.Automation.Host.ChoiceDescription("&Quit","Abort this script.")
    )
    $global:selection = $Host.UI.PromptForChoice("Auto-Setup Step Selection","Which step would you like to proceed with?",$setupSteps,3)

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
    }
    # else quiting...
}

# -----------------

echo "Automated setup for new Windows installation will start in a few seconds..."
Start-Sleep 4
henry-showSetupSteps

echo "Quitting..."
Start-Sleep 4
