$ErrorActionPreference = 'Stop';

$url32          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.2/Sigil-1.9.2-Windows-Setup.exe'
$url64          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.2/Sigil-1.9.2-Windows-x64-Setup.exe'
$urlLegacy      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.2/Sigil-1.9.2-Windows-Legacy-Setup.exe'
$checksum       = '3763a3a004c64b2b18e5b25e5d604793d22c33ecc6830175751e41ad6cd6a296'
$checksum64     = '50ee720dcfbed536502939aef7918d4f8192bc2e2458efda992de49d6129f543'
$checksumLegacy = 'e6730a28f0a0d996316ab1597ac6fa26ce4edc8929aea9aae0b54de59f4277e6'

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
