$Date = get-date "1/12/16"
#$Date = $date.AddDays(3)

$S = 1
do
{
    $Date
    $Date = $Date.AddDays(7)
    $S++
}while($S -lt 18)
