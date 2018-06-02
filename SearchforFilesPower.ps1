param(
    [string] $match = "Add",
    [string]$dir = "D:\",
    [string]$filter = "*.cs"
)

Write-Host "---------------------------------Start---------------------------------"

$files = Get-ChildItem -Path $dir -Filter $filter -Recurse

foreach ($file in $files) {
    $content = $file | Get-Content

    if ($content -match $match) {
        Write-Host $file.FullName
        $content | Select-String -Pattern $match | Select-Object -Property LineNumber, Line | Out-Host
    }
}

Write-Host "---------------------------------End---------------------------------"