$ErrorActionPreference = 'Stop';

if (Get-OSArchitectureWidth -Compare 32) {
  throw "Sigil is no longer available in 32-bit since version 2.0.0, pin the package version to 1.9.30 with command ``choco pin add --name=`"'sigil'`" --version=`"'1.9.30'`"``"
}

if ([System.Environment]::OSVersion.Version -lt (new-object 'Version' 10, 0, 17763)) {
  throw "Sigil is only available for Windows 10 Version 1809 or higher since version 2.0.0, pin the package version to 1.9.30 with command ``choco pin add --name=`"'sigil'`" --version=`"'1.9.30'`"``"
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url64bit      = 'https://github.com/Sigil-Ebook/Sigil/releases/download/2.1.0/Sigil-2.1.0-Windows-x64-Setup.exe'
	
  softwareName  = 'sigil'

  checksum64    = '1048e93afbb64d7dbfa61be80cfb677f1c6b6bf72efd4b89c891a358e34094bd'
  checksumType64= 'sha256'

  silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
