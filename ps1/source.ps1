<#
Description: Model Script - Print received args in JSON forma. Printed output is formatted as input to the next task.
Execution from cmd: powershell.exe -NonInteractive -ExecutionPolicy ByPass -File "example.ps1 Hello World"
 #>
 
$output = New-Object -TypeName PSObject

$state = 'success'


# Do your stuff, change success status to failure to denote failed execution


If ($state  -eq 'success')  {

    Add-Member -InputObject $output -NotePropertyName state -NotePropertyValue sucess
}
else
{
    Add-Member -InputObject $output -NotePropertyName state -NotePropertyValue failure
}

#Prepare output, add state and data to be passed trough tasks in a workflow
Add-Member -InputObject $output data $args
 
# Write JSON Output as follows: {"state":"failure","data":["arg0","arg1","arg2","arg3"]}

ConvertTo-Json -InputObject $output -Compress

