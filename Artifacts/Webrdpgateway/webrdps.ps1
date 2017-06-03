function Create-Folder {
    Param ([string]$path)
    if ((Test-Path $path) -eq $false) 
    {
        Write-Host "$path doesn't exist. Creating now.."
        New-Item -ItemType "directory" -Path $path
    }
}

function Download-File{
    Param ([string]$src, [string] $dst)

    (New-Object System.Net.WebClient).DownloadFile($src,$dst)
    #Invoke-WebRequest $src -OutFile $dst
}

function WaitForFile($File) {
  while(!(Test-Path $File)) {    
    Start-Sleep -s 10;   
  }  
} 


#Setup Folders

$setupFolder = "c:\gatewaytohell"
Create-Folder "$setupFolder"

Create-Folder "$setupFolder\training"
$setupFolder = "$setupFolder\training"

$os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x64)’

# Web rdp gateway Installation 
if((Test-Path "$setupFolder\webRDP-Gateway_1.2.0.43-Win-64.exe") -eq $false)
{
    Write-Host "Downloading Webrdp installation file.."
    if ($os_type -eq "True"){
        Download-File "https://cradle123-my.sharepoint.com/personal/cradleoffilth_cradle123_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=17951eec4d0e24cfdb479746f0decae7e&authkey=ASdSTqhXPaJJMmQ0NRuXpvU" "$setupFolder\webRDP-Gateway_1.2.0.43-Win-64.exe"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}
# download webrdp auto it exe
if((Test-Path "$setupFolder\webrdpgatewayscript.exe") -eq $false)
{
    Write-Host "Downloading Webrdp installation file.."
    if ($os_type -eq "True"){
        Download-File "https://cradle123-my.sharepoint.com/personal/cradleoffilth_cradle123_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=139d79315e4ec421fbfcbff3d6336fca3&authkey=AQHezZo53le0h4cKlUKXkpc" "$setupFolder\webrdpgatewayscript.exe"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}

#download license
if((Test-Path "$setupFolder\G7_CR_Technologies-license.swl") -eq $false)
{
    Write-Host "Downloading Webrdp license file.."
    if ($os_type -eq "True"){
        Download-File "https://cradle123-my.sharepoint.com/personal/cradleoffilth_cradle123_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=14f7747c19fc34c5ea0a50e496499e273&authkey=ATTn7AjZ-r-ANVMmGR1Klrk" "$setupFolder\G7_CR_Technologies-license.swl"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}
# download background image
Write-Host "Downloading background image.."
if((Test-Path "$setupFolder\M4LCircle.png") -eq $false)
{
    Write-Host "Downloading  background file.."
    if ($os_type -eq "True"){
        Download-File "https://cradle123-my.sharepoint.com/personal/cradleoffilth_cradle123_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=17da86e35929a429fbebcd660a8dbde2b&authkey=AfbvufEaHLtTSz313DDGotM" "$setupFolder\M4LCircle.png"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}
# download logo
Write-Host "Downloading logo.."
if((Test-Path "$setupFolder\Logo_Part1_White_100_45.png") -eq $false)
{
    Write-Host "Downloading logo.."
    if ($os_type -eq "True"){
        Download-File "https://cradle123-my.sharepoint.com/personal/cradleoffilth_cradle123_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=16cdb427de8c549798a3f0f02d99c91f0&authkey=AdXF9-aIOMMGHxgzki4XHLQ" "$setupFolder\Logo_Part1_White_100_45.png"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}
try {
    Write-Host "Installing webrdp.."
Start-Process -FilePath "$setupFolder\webrdpgatewayscript.exe"
}
catch {
    Write-Error 'Failed to install VSCode'
}


