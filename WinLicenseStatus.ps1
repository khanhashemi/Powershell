$WinLicenseStatus = Get-CimInstance -ClassName SoftwareLicensingProduct  -Filter "PartialProductKey IS NOT NULL" | Where-Object Name -like "Windows*" 
$Status = if ($WinLicenseStatus.LicenseStatus -eq 1) { "Activated" } else { "Not Activated" }
$Status 
