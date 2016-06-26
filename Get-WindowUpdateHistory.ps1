Function Get-MicrosoftUpdates
{ 
  Param(
        $NumberOfUpdates,
        [switch]$all
       )
  $Session = New-Object -ComObject Microsoft.Update.Session
  $Searcher = $Session.CreateUpdateSearcher()
  if($all)
    {
      $HistoryCount = $Searcher.GetTotalHistoryCount()
      $Searcher.QueryHistory(0,$HistoryCount)
    }
  Else { $Searcher.QueryHistory(0,$NumberOfUpdates) }
} #end Get-MicrosoftUpdates

$Updates = Get-MicrosoftUpdates -NumberOfUpdates 100 #| where-object ($_.title -notlike "*Definition Update for Microsoft Endpoint Protection*")


#$Updates | get-member

foreach ($Update in $Updates)
{
write-host $Update.title
}