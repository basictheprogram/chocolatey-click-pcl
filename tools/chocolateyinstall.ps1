$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url64       = 'https://ftp.automationdirect.com/pub/clicksoftware_v240.zip'
$checksum64  = '99af9e0977ba0111fe538f5d9665a438342290a56aef2e52f06677cf1b6f8f2f'
$WorkSpace   = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"

$WebFileArgs = @{
  packageName  = $packageName
  FileFullPath = Join-Path $WorkSpace "$packageName.zip"
  Url64bit     = $url64
  Checksum64   = $checkSum64
  ChecksumType = 'sha256'
  GetOriginalFileName = $true
  SoftwareName   = 'CLICK PCL*'

}

$PackedInstaller = Get-ChocolateyWebFile @WebFileArgs

$UnzipArgs = @{
  PackageName  = $packageName
  FileFullPath = $PackedInstaller
  Destination  = $WorkSpace
}

Get-ChocolateyUnzip @UnzipArgs

# silent install requires AutoIT
#
$autoitExe    = 'AutoIt3.exe'
$toolsDir     = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$autoitFile   = Join-Path $toolsDir 'click-pcl.au3'
$fileFullPath = Join-Path $WorkSpace 'Click_Setup.exe'
Write-Debug "AutoItFile: `t$autoitFile"
Write-Debug "FileFullPath `t$fileFullPath"

$autoitProc   = Start-Process -FilePath $autoitExe -ArgumentList "$autoitFile $fileFullPath" -PassThru
$autoitId     = $autoitProc.Id
Write-Debug "autoitProc `t$autoitProc"
Write-Debug "$autoitExe start time:`t$($autoitProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID: `t$autoitId"