$oProcesses= Get-WmiObject -Class Win32_Process
$aObjects=@()
ForEach($oProcesses in $oProcesses)
{
 $oMem = $oProcesses.GetAvailableVirtualSize()
 $oObject=New-Object pscustomobject
 Add-Member -InputObject $oObject -MemberType NoteProperty -Name 'Name'  -Value ($oProcesses.Name) -Force

  Add-Member -InputObject $oObject -MemberType NoteProperty -Name 'AvailableVirtualSize' -Value $($oMem.AvailableVirtualSize) -Force
  $aObjects+=@($oObject)
}
$aObjects | Sort-Object AvailableVirtualSize -Descending | ft -AutoSize