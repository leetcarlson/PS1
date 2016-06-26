function create-semesterArchiveStructure {
<#
.Synopisis
Create consistant directory structure for semester archives

.Description
Automattically creates a directory structure for my data archives for each semester.
It will provide consistancy in how the folders are structured, as well as provide me with
reminder of the information that I should be archiving.  This is only the folder setup, the data
will need to be added by other means.

.Author
Lee Carlson

.Created
2/3/2016

.Current Version
1.00 

.VersionDates
1.00 - 2/3/2016

.Parameter
-semester = Required = Semester name "Fall, Summer, Spring"
-Year = Required = 2 or 4 digit representation of the year
-Path = Optional = Root directory for the folder ie "H:\Semester Archives\"
#>
[CmdletBinding()]
param 
(
[Parameter()]
[string]$Semester,
[int]$Year,
[string]$Path = "H:\Semester Archives\"
)
if ($Semester -eq "")
    {
    echo "Must have both year and semester to continue.`RThey can be Semester name ie Fall, Summer, etc or code. Year can be in 2 or 4 digits."
    }

if($Year -lt 10)
    {
    $Year = (Get-Date -Format "yyyy")
    }
elseif(($Year -gt 10) -and ($Year -lt 99))
    {
    $Year = $Year + 2000
    }

Switch($Semester)
    {
    10 {$SemesterNumber = 10
        $SemesterName = "Spring"}
    20 {$SemesterNumber = 20
        $SemesterName = "Fall"}
    30 {$SemesterNumber = 30
        $SemesterName = "Summer"}
    "Spring" {$SemesterNumber = 30
     $SemesterName = "Spring"}
    "Fall" {$SemesterNumber = 20
    $SemesterName = "Fall"}
    "Summer" {$SemesterNumber = 10
    $SemesterName = "Summer"}
    default{$SemesterNumber = $0
    $SemesterName = "Error"}
    }
    
$FullSemesterPath = $Path + $Year + "-" + $SemesterNumber + " " + "(" + $SemesterName + " " + $Year + ")\"

echo $FullSemesterPath

$ArchivePaths = "","Student Com\", "Student Data\", "Student Data\Grades\", "Student Data\Student Work", "Student Data\Student Work\Graded\". 
"Student Data\Student Work\Grading Notes\", "Student Data\Graded\", "Student Data\Grading Notes\", "Integrity Violations\",
"Student Data\Attendence\", "BB Backup", "BB Backup\Syllabus\", "BB Backup\Calendar\", "Student Data\Final Grades\"

foreach($ArcivePath in $ArchivePaths)
{
    $FullArchivePath = $FullSemesterPath + $ArcivePath
    echo "Creating $FullArchivePath"
    create-semesterPath -Path $FullArchivePath
}

}
function create-SemesterPath {
<#
.Synopisis
Simple directory creation script with check (to avoid) dupes

.Description
Simple directory creation script that checks to see if a directory already
exists, it will pass by.

.Author
Lee Carlson

.Created
2/16/2016

.Current Version
1.00 

.VersionDates
1.00 - 2/16/2016

.Parameter
-Path = Folder to be created
#>
[CmdletBinding()]
param 
(
[Parameter()]
[string]$Path
)

if(Test-Path $Path)
{
echo "$Path already exists."
}
else
{
    New-Item -ItemType directory -Path $Path
    echo "$Path created."
}

}
create-semesterArchiveStructure -Semester Summer -Year 16