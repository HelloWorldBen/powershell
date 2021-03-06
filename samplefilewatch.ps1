﻿$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path ="D:\Temp"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true
$changed = Register-ObjectEvent $watcher "Changed" -Action {
   write-host "Changed: $($eventArgs.FullPath)"
}
$created = Register-ObjectEvent $watcher "Created" -Action {
   write-host "Created: $($eventArgs.FullPath)"
}
$deleted = Register-ObjectEvent $watcher "Deleted" -Action {
   write-host "Deleted: $($eventArgs.FullPath)"
}
$renamed = Register-ObjectEvent $watcher "Renamed" -Action {
   write-host "Renamed: $($eventArgs.FullPath)"
}

Unregister-Event $changed.Id
Unregister-Event $created.Id
Unregister-Event $deleted.Id
Unregister-Event $renamed.Id