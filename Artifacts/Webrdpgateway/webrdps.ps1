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

# SQL Server Installation 
if((Test-Path "$setupFolder\webRDP-Gateway_1.2.0.43-Win-64.exe") -eq $false)
{
    Write-Host "Downloading Webrdp installation file.."
    if ($os_type -eq "True"){
        Download-File "https://bedofrazors-my.sharepoint.com/personal/pro_bedofrazors_onmicrosoft_com/_layouts/15/guestaccess.aspx?docid=102e4dd8037054e788357fd9763af99d8&authkey=AVJjvuxk6eWahwBhcqxIHjM" "$setupFolder\webRDP-Gateway_1.2.0.43-Win-64.exe"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}

# Prepare Configuration file
Write-Host "Preparing configuration file.."
if((Test-Path "$setupFolder\webrdp.ini") -eq $false)
{
    Write-Host "Downloading  installation file.."
    if ($os_type -eq "True"){
        Download-File "https://github.com/sproloy/gatewaywebrdp/blob/master/Artifacts/Webrdpgateway/webrdp.ini" "$setupFolder\webrdp.ini"
    }else {
        Write-Host "32 Bit system is not supported"
    }    
}



Write-Host "Installing.."
Start-Process -FilePath "$setupFolder\webRDP-Gateway_1.2.0.43-Win-64.exe" -ArgumentList '/ConfigurationFile="c:\gatewaytohell\training\webrdp.ini"'


Write-Host 'Installation completed.'