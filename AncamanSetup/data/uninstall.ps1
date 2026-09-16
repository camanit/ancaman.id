# ============================================================
#  Uninstaller Antivirus Ancaman
#  Jalankan sebagai Administrator
# ============================================================

$ErrorActionPreference = "SilentlyContinue"

Write-Host ""
Write-Host "  MENGHAPUS INSTALASI ANTIVIRUS ANCAMAN..." -ForegroundColor Yellow
Write-Host ""

# Hentikan semua proses
Write-Host "[1/3] Menghentikan semua proses Ancaman..." -ForegroundColor Green
@("ancaman-gui", "ancaman-server", "ancaman-agent") | ForEach-Object {
    $proc = Get-Process -Name $_ -ErrorAction SilentlyContinue
    if ($proc) {
        $proc | Stop-Process -Force -ErrorAction SilentlyContinue
        Write-Host "  OK - Proses '$_' dihentikan." -ForegroundColor Yellow
    }
}
Start-Sleep -Seconds 1

# Hapus Windows Service (jika ada dari instalasi lama)
Write-Host ""
Write-Host "[2/3] Menghapus Windows Service (jika ada)..." -ForegroundColor Green
$svc = Get-Service -Name "AncamanAgent" -ErrorAction SilentlyContinue
if ($svc) {
    Stop-Service -Name "AncamanAgent" -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    sc.exe delete "AncamanAgent" | Out-Null
    Write-Host "  OK - Service AncamanAgent dihapus." -ForegroundColor Green
} else {
    Write-Host "  OK - Tidak ada service untuk dihapus." -ForegroundColor Green
}

# Hapus folder instalasi
Write-Host ""
Write-Host "[3/3] Menghapus file instalasi..." -ForegroundColor Green
$installDir = "C:\Program Files\Ancaman"
if (Test-Path $installDir) {
    Remove-Item -Path $installDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  OK - Folder '$installDir' dihapus." -ForegroundColor Green
}

# Hapus shortcut Desktop dan Startup
$desktopPath  = [Environment]::GetFolderPath("CommonDesktopDirectory")
$shortcutPath = Join-Path $desktopPath "Ancaman Antivirus.lnk"
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath -Force
    Write-Host "  OK - Shortcut desktop dihapus." -ForegroundColor Green
}

$startupPath = Join-Path ([Environment]::GetFolderPath("CommonStartup")) "Ancaman Antivirus.lnk"
if (Test-Path $startupPath) {
    Remove-Item $startupPath -Force -ErrorAction SilentlyContinue
    Write-Host "  OK - Startup shortcut dihapus." -ForegroundColor Green
}

# Hapus Registry Auto-Start
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "AncamanAntivirus" -ErrorAction SilentlyContinue
Write-Host "  OK - Registry Auto-Start dibersihkan." -ForegroundColor Green


Write-Host ""
Write-Host "  =========================================" -ForegroundColor Cyan
Write-Host "   UNINSTALL SELESAI!                      " -ForegroundColor Green
Write-Host "  =========================================" -ForegroundColor Cyan
Write-Host ""

pause
