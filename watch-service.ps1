Function Compare-MaintTime {
<#
.Synopisis
Validates if we are on a maintanance cycle or not

.Description
Checks current time to see if we are in a maintanance window.  
If we are in a maintanance windows the script will surpress errors
until after the window is over.

.Parameter
-Environemnet = Indicate if Production

.Dependencies
No Dependencies

.Author
Lee Carlson

.Verson 1.0

.Last Updated
05.13.14
#>
param 
(
[Parameter[string]$Environment = "TEST"
)
$CurrentDateTime = get-date

    if ($Environment = "Prod")
    {
        if($CurrentDateTime.dayofweek -eq 'Wednesday' -and $CurrentDateTime.hour -gt 12 -and $CurrentDateTime.hour -lt 16)
        {
            Return $False    
        }
        else
        {
            Return $True
        }
    }
    else
    {
        Return $True
    }
}


$Process = Get-Process | where-object {$_.name -like 'Apple Mobile*'}

while ($Process.state -ne 'Stopped')
{
    start-sleep -s 1

}
