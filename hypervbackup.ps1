$date = Get-Date -Format "yyyyMMdd"

$s1 = (gwmi -List Win32_ShadowCopy).Create("d:\", "ClientAccessible")
$s2 = gwmi Win32_ShadowCopy | ? { $_.ID -eq $s1.ShadowID }
$d  = $s2.DeviceObject + "\"
cmd /c mklink /d d:\shadowcopy "$d"

$targetDir = "N:\vmbackup\$date"

if(-not (Test-Path $targetDir)) { 
    New-Item -ItemType Folder -Path $targetDir
}

robocopy D:\shadowcopy\Hyper-V "$targetDir" /e /np

"vssadmin delete shadows /Shadow=""$($s2.ID.ToLower())"" /Quiet" | iex

Remove-Item d:\shadowcopy -Confirm:$false -Force