$ErrorActionPreference = 'Stop';

$url32          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.30/Sigil-1.9.30-Windows-Setup.exe'
$url64          = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.30/Sigil-1.9.30-Windows-x64-Setup.exe'
$urlLegacy      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/1.9.30/Sigil-1.9.30-Windows-Legacy-Setup.exe'
$checksum       = '048758dcc45b84cd4512d3eccb4d148af6ad395a05f1e177113557152123f776'
$checksum64     = '9dd6bf318de813a0e2120dde81c4d17a7f6b7c3c1c25312f3adf68f23176713a'
$checksumLegacy = 'ce4034bf51fc9ab7cf56201d736eeb395b6ebcea015708b1d09b8b0faa98b069'

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
