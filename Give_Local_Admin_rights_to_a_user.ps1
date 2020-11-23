 # **************************************************************
# 
#  
# Author: Khanagha Hashemi
#       
#     
# **************************************************************
function Give_Local_Admin_rights_to_a_user{
Param(
[Parameter(Mandatory=$True)]
[string]$user
)
$admingrp = Get-LocalGroup  -SID 'S-1-5-32-544' |  select -ExpandProperty name
$GroupMembers = Get-LocalGroupMember -SID 'S-1-5-32-544' | Select-Object -ExpandProperty name

$alreadyadmin = $false
foreach($s in $GroupMembers)
    {
        $findbackslash = $s.IndexOf("\")
        $length = $s.Length
     
        $result = $s.substring($findbackslash)
        $GroupMember = $result.substring(1)
        if($GroupMember -eq $user ){
      
           $alreadyadmin = $true

        }
    
    }
    if($alreadyadmin -eq $true)
    {
       Write-Host "$user is already an Administrator account"
     }
     else{
      
          try{
              Add-LocalGroupMember  -Group $admingrp -Member $user -ErrorAction Stop
              Write-Host "$user is now an Administrator account"
          }catch{
            Write-Host "$user not found"
          }
      }
    }
