[cmdletbinding()]            
param(            
 [parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]            
 [string[]]$ComputerName = $env:computername,            
 [parameter(mandatory=$true)]            
 [string]$UserName          
)           
Begin {}           
Process {            
            
    foreach($Computer in $ComputerName) {            
     Write-Verbose "Working on $Computer"            
     if(Test-Connection -ComputerName $Computer -Count 1 -ea 0) {            
      $Profiles = Get-WmiObject -Class Win32_UserProfile -Computer $Computer -ea 0            
      foreach ($profile in $profiles) {            
       $objSID = New-Object System.Security.Principal.SecurityIdentifier($profile.sid)            
       $objuser = $objsid.Translate([System.Security.Principal.NTAccount])            
       $profilename = $objuser.value.split("\")[1]            
       if($profilename -eq $UserName) {            
        $profilefound = $true            
        try {            
         $profile.delete()            
         Write-Host "$UserName profile deleted successfully on $Computer"            
        } catch {            
         Write-Host "Failed to delete the profile, $UserName on $Computer"            
        }            
       }            
      }            
            
      if(!$profilefound) {            
       write-Warning "No profiles found on $Computer with Name $UserName"            
      }            
     } else {            
      write-verbose "$Computer Not reachable"            
     }            
    }            
            
    }            
            
end {}