$ErrorActionPreference = 'Stop';

$url32          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.10/Sigil-1.9.10-Windows-Setup.exe'
$url64          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.10/Sigil-1.9.10-Windows-x64-Setup.exe'
$urlLegacy      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.10/Sigil-1.9.10-Windows-Legacy-Setup.exe'
$checksum       = '135cb9e6675e3d3207667af53f90dbe7986d4566ddcb31a00f5a0b35ef852492'
$checksum64     = 'e9fb15c894e5174d86b9da1aa1b835b81e46cd2c738816d00d59d084bcf1256f'
$checksumLegacy = 'ff9f1cc3ac28eafcd8d45052aa5be2b8e5343de84e513c993e296830d3f574cd'

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
