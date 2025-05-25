[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Get Downloads folder path
$DownloadsPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
Set-Location -Path $DownloadsPath

# Define file and paths
$zipName = "ALICS.zip"
$folderName = "ALICS"
#$downloadUrl = "https://github.com/Louisjreeves/WinClusArcHelper/raw/refs/heads/main/$zipName"
$downloadUrl = "https://github.com/Louisjreeves/WinClusArcHelper/raw/refs/heads/main/ALICS.zip"
$zipPath = Join-Path $DownloadsPath $zipName
$extractPath = Join-Path $DownloadsPath $folderName

# Download ZIP
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -UseBasicParsing -ErrorAction Stop
} catch {
    Write-Error "Download failed: $($_.Exception.Message)"
    exit 1
}

# Extract it
try {
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
} catch {
    Write-Error "Failed to unzip $zipName"
    exit 1
}

 $scriptFileName = "ALICS.ps1"
$scriptPath = Join-Path $extractPath $scriptFileName

if (Test-Path $scriptPath) {
    Set-Location -Path $extractPath
    & $scriptPath
} else {
    Write-Error "Script not found: $scriptPath"
    exit 1
}
