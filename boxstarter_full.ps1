#
# Install boxstarter:
# 	. { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
#
# Set-ExecutionPolicy Unrestricted
#
# Run this boxstarter by calling the following from an **elevated** command-prompt:
# 	start http://boxstarter.org/package/nr/url?<URL-TO-RAW-GIST>
# OR
# 	Install-BoxstarterPackage -PackageName <URL-TO-RAW-GIST> -DisableReboots
#
# Learn more: http://boxstarter.org/Learn/WebLauncher

# Avoid UAV dialog boxes
Disable-UAC

# Enable remote desktop
Enable-RemoteDesktop

# Windows Settings
Disable-GameBarTips

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
Set-TaskbarOptions -Dock Bottom -Combine Full -Lock
Set-TaskbarOptions -Dock Bottom -Combine Full -AlwaysShowIconsOn

Update-ExecutionPolicy Unrestricted
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

# source control tools
choco install git #-params '"/GitAndUnixToolsOnPath"'
choco install poshgit

# utilities
choco install docker
choco install 7zip
choco install ditto 
choco install ilspy
#choco install NugetPackageExplorer
choco install astrogrep
choco install everything
#choco install vagrant
choco install greenshot
choco install scriptcs
choco install linqpad
choco install zoomit
choco install licecap
choco install spotify
choco install nuget.commandline
choco install ditto
choco install mousewithoutborders
#choco install azure-documentdb-emulator

# editors
choco install firacode #font
choco install inconsolata #font
choco install visualstudio2019enterprise #this ony installs the shell, you will need to launch the installer and install the options
choco install vscode-insiders
choco install python --pre

# browsers
choco install Firefox

# Powershell Modules
Install-Module -Name AzureADPreview
Install-Module -Name Az -AllowClobber -Force

# Visual Studio Code Extensions
choco install vscode-settingssync

# Stuff not on chocolatey
# https://github.com/Microsoft/AzureKeyVaultExplorer

# Windows Subsystems/Features
choco install Microsoft-Hyper-V-All -source windowsFeatures
choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

# Install new Windows terminal app
Get-AppxPackage Microsoft.WindowsTerminal | Install-AppxPackage

# Remove unwanted windows apps
# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# BubbleWitch
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage

# Candy Crush
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage

# Feedback Hub
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

# Get Started
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage

# Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

# Messaging
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage

# Minecraft
Get-AppxPackage *Minecraft* | Remove-AppxPackage

# Netflix
Get-AppxPackage *Netflix* | Remove-AppxPackage

# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage

# Misc Windows Settings
# Privacy: Let apps use my advertising ID: Disable
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# Better File Explorer
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1		
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1		
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives  -EnableShowFileExtensions -EnableShowFullPathInTitleBar

# Disable the Lock Screen (the one before password prompt - to prevent dropping the first character)
If (-Not (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization)) {
	New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name Personalization | Out-Null
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1
# To Restore:
# Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1

# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0

# Windows Settings
Enable-MicrosoftUpdate
Install-WindowsUpdate -getUpdatesFromMS -acceptEula -SuppressReboots

#--- Restore Temporary Settings ---
# Enable-UAC

#--- Rename the Computer ---
# Requires restart, or add the -Restart flag
$computername = "Tron"
if ($env:computername -ne $computername) {
	Rename-Computer -NewName $computername
}

# Fix SSH-Agent error by adding the bin directory to the `Path` environment variable
$env:PSModulePath = $env:PSModulePath + ";C:\Program Files (x86)\Git\bin"

# Tweaks
#========
#Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles)\Google\Chrome\Application\chrome.exe"

