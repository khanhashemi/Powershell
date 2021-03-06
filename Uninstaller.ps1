 
# **************************************************************
# 
#  
# Author: Khanagha Hashemi
#       
#     
# **************************************************************
 function Uninstaller{

param(
[parameter(Mandatory=$true)]
[string] $Displayname

)

$apps = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\  |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -eq $Displayname}  |
            Select-Object -Property UninstallString,DisplayName
         

  # wenn apps gefunden werden dann werden diese deinstalliert
    if(![string]::IsNullOrEmpty($apps)){

        foreach($uninstall in  $apps ){

            $unins = $uninstall.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""

            start-process "msiexec.exe" -arg "/X $unins /qn" -Wait
            
        }    
    }else{Write-Host "$Displayname not found "}

} 
