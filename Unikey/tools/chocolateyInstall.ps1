$package = 'Unikey'
$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutPath = Join-Path "$programs" $package
$shortcutFilePath = Join-Path $shortcutPath "UniKeyNT.lnk"
if(!(Test-Path $shortcutPath)) {
    md $shortcutPath
}

$targetPath = Join-Path $installDir "..\UniKeyNT.exe"
if(Get-Command "Install-ChocolateyShortcut" -ErrorAction SilentlyContinue) { # New, compiled Choco
    Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath
}
else { # PowerShell Choco
    $shell = New-Object -comObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutFilePath)
    $shortcut.TargetPath = $targetPath
    $shortcut.Save()
}
