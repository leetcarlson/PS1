# get-shell.ps1
# Sample for MSDN Wiki
# Thomas Lee - tfl@.psp.co.uk

# get object
$shell  = new-object -com shell.application

# Display members of the shell.application object
#$shell | get-member

$shell.open('C:\')
