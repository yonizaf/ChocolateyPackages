$ErrorActionPreference = 'Stop';

$url32          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.20/Sigil-1.9.20-Windows-Setup.exe'
$url64          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.20/Sigil-1.9.20-Windows-x64-Setup.exe'
$urlLegacy      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.20/Sigil-1.9.20-Windows-Legacy-Setup.exe'
$checksum       = 'afb336d379abf989a7e8940d33c15bb91664b6e28fde3f0d15644014609fd066'
$checksum64     = '9ee1e4f62927afd21011ca567d343cbf441e5fb371f20743756b7a89b3ea2af8'
$checksumLegacy = 'dfcc707c6c5b8b7475b4154d554f1053f9b40b319a3b9cac8978365fcf641ccb'

if ([System.Environment]::OSVersion.Version -lt (new-object 'Version' 6, 2)) {
	Write-Host "Installing Legacy version for Windows 7"; 
	$url32 = $url64 = $urlLegacy
	$checksum = $checksum64 = $checksumLegacy
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url32
  url64bit      = $url64
	
  softwareName  = 'sigil'

  checksum      = $checksum
  checksum64    = $checksum64
  checksumType  = 'sha256'
  checksumType64= 'sha256'

  silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
