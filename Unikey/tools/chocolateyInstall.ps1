$package = 'Unikey'
$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$programs = [environment]::GetFolderPath([environment+specialfolder]::Programs)
$shortcutPath = Join-Path "$programs" $package
$shortcutFilePath = Join-Path $shortcutPath "UniKeyNT.lnk"
if(!(Test-Path $shortcutPath)) {
    md $shortcutPath
}

$targetPath = Join-Path $installDir "..\UniKeyNT.exe"
Install-ChocolateyShortcut -shortcutFilePath $shortcutFilePath -targetPath $targetPath
