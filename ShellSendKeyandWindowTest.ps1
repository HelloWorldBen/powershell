  $shell = new-object -com shell.application 
  $shell.Windows().Count

$shell | Get-Member
$shell.FileRun()

$wshell = New-Object -ComObject wscript.shell;
$wshell.SendKeys('abcd')



$shell.WindowSwitcher()