$BinPath     = "C:\mbr.bin"
$DiskNumber  = 0

$mbrData = [System.IO.File]::ReadAllBytes($BinPath)
if ($mbrData.Length -ne 512) {
    Write-Error "MBR must be exactly 512 bytes."
    exit
}

$disk = [System.IO.File]::Open(
    "\\.\PhysicalDrive$DiskNumber",
    [System.IO.FileMode]::Open,
    [System.IO.FileAccess]::Write,
    [System.IO.FileShare]::ReadWrite
)

$disk.Write($mbrData, 0, 512)
$disk.Flush()
$disk.Close()
