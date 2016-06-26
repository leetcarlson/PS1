# xlDirection is the parent containing constants related to Direction:
$xlDirection = "microsoft.office.interop.excel.xlDirection" -as [type] 
$xlDown = $xlDirection::xlDown
$xlUp = $xlDirection::xlUp
$xlDown.value__
$xlUp.value__
#Constants End

$XLS = 'c:\scripts\grad.xlsx'

$excel = New-Object -ComObject Excel.Application

#$ExcelMember = $excel | Get-Member

$excel.Visible = $false
$workbook = $excel.Workbooks.open($XLS)
$WorkSheet = $excel.sheets.item(1)
#$SelRow = $worksheet.cells.item(2,2).entireRow
#$active = $SelRow.activate()
#$active = $selRow.insert($xlDown)

$counter = 0

$counter++
$WorkSheet.cells.Item(1,1) = "NAME"
$WorkSheet.cells.Item(1,2) = "Definition"

#$addNew = $excel.sheets.add()
#$SaveMe = $excel.sheets.save()

$excel.Visible = $true