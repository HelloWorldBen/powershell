
<#

ProcDump Script

#>


try
{
    



#give the process name without exe 
$processName = 'Notepad'

#will process list
$processes = Get-Process $processName |select -expand id 

 
#for each id loop through and get the dumps 
foreach ($process in $processes){ 
  
$workingDirectory = 'D:\powershell\test'


#give the location of procdump as it per remote machine
$procdump =  'D:\powershell\procdump.exe'

#give the parameters for procdump then concat with process id 
$arguments = '-accepteula -ma -l  -n 5 ' +$process.ToString()

 

#starts procdump with arguments place the files in working directory 
Start-Process -FilePath $procdump -ArgumentList $arguments -WorkingDirectory $workingDirectory


#launch a new instance of procdump after 20 seconds
Start-Sleep -s 20

}
    


    Start-Sleep -s 500
    Write-Host 'Completed successfuly'

}

 Catch
{
    $ErrorMessage = $_.Exception.Message
    Write-Host 'Error Message'
}
 


