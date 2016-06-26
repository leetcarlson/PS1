Function Get-OutlookAppointments {
   param ( 
         [Int] $NumDays = 7,
         [DateTime] $Start = [DateTime]::Now ,
            [DateTime] $End   = [DateTime]::Now.AddDays($NumDays)
   )
 
   Process {
      $outlook = New-Object -ComObject Outlook.Application
 
      $session = $outlook.Session
      $session.Logon()
 
      $apptItems = $session.GetDefaultFolder(9).Items
      $apptItems.Sort("[Start]")
      $apptItems.IncludeRecurrences = $true
      $apptItems = $apptItems
 
      $restriction = "[End] >= '{0}' AND [Start] <= '{1}'" -f $Start.ToString("g"), $End.ToString("g")
 
      foreach($appt in $apptItems.Restrict($restriction))
      {
        $apptItems
        write-host "-----------------------"
        write-host "`r`r"          
      }
 
      $outlook = $session = $null;
   }
}
 
Get-OutlookAppointments -Start 6/11/16