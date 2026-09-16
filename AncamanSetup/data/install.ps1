# ============================================================
#  Installer Antivirus Ancaman — v0.1 (Tauri Desktop Edition)
#  Jalankan sebagai Administrator: klik kanan -> Run as Admin
# ============================================================

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "  =========================================" -ForegroundColor Cyan
Write-Host "   ANTIVIRUS ANCAMAN — Enterprise Edition  " -ForegroundColor Cyan
Write-Host "   Proteksi Siber Kedaulatan Indonesia      " -ForegroundColor Cyan
Write-Host "  =========================================" -ForegroundColor Cyan
Write-Host ""

# ── 1. Cek Admin ───────────────────────────────────────────
Write-Host "[1/5] Memeriksa hak akses administrator..." -ForegroundColor Green
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERROR: Harus dijalankan sebagai Administrator!" -ForegroundColor Red
    Write-Host "Klik kanan file ini -> 'Run as Administrator'" -ForegroundColor Yellow
    pause; exit 1
}
Write-Host "  OK - Hak Administrator dikonfirmasi." -ForegroundColor Green

# ── 2. Lokasi File Sumber ──────────────────────────────────
# Script ini harus ada di folder yang sama dengan .exe
$scriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$guiExe     = Join-Path $scriptDir "ancaman-gui.exe"
$serverExe  = Join-Path $scriptDir "ancaman-server.exe"
$webDir     = Join-Path $scriptDir "web"

Write-Host ""
Write-Host "[2/5] Memeriksa file instalasi..." -ForegroundColor Green

if (-not (Test-Path $guiExe)) {
    Write-Host "ERROR: ancaman-gui.exe tidak ditemukan di: $scriptDir" -ForegroundColor Red
    Write-Host "Pastikan semua file berada di folder yang sama dengan installer ini." -ForegroundColor Yellow
    pause; exit 1
}
if (-not (Test-Path $serverExe)) {
    Write-Host "ERROR: ancaman-server.exe tidak ditemukan di: $scriptDir" -ForegroundColor Red
    pause; exit 1
}

Write-Host "  OK - Semua file ditemukan." -ForegroundColor Green

# ── 3. Hapus Instalasi Lama ────────────────────────────────
Write-Host ""
Write-Host "[3/5] Membersihkan instalasi lama (jika ada)..." -ForegroundColor Green
$installDir  = "C:\Program Files\Ancaman"
$serviceName = "AncamanAgent"

# Hentikan dan hapus Windows Service lama
$svc = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
if ($svc) {
    Write-Host "  Menghentikan service lama '$serviceName'..." -ForegroundColor Yellow
    if ($svc.Status -eq "Running") {
        Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }
    sc.exe delete $serviceName | Out-Null
    Start-Sleep -Seconds 1
    Write-Host "  OK - Service lama dihapus." -ForegroundColor Green
}

# Matikan proses yang mungkin sedang berjalan
@("ancaman-gui", "ancaman-server", "ancaman-agent") | ForEach-Object {
    $proc = Get-Process -Name $_ -ErrorAction SilentlyContinue
    if ($proc) {
        $proc | Stop-Process -Force -ErrorAction SilentlyContinue
        Write-Host "  OK - Proses '$_' dihentikan." -ForegroundColor Yellow
    }
}

Start-Sleep -Seconds 1
Write-Host "  OK - Pembersihan selesai." -ForegroundColor Green

# ── 4. Salin File ke Program Files ────────────────────────
Write-Host ""
Write-Host "[4/5] Menginstall ke '$installDir'..." -ForegroundColor Green

if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

# Salin executable utama
Copy-Item -Path $guiExe    -Destination "$installDir\ancaman-gui.exe"    -Force
Copy-Item -Path $serverExe -Destination "$installDir\ancaman-server.exe" -Force

# Salin folder web (UI)
if (Test-Path $webDir) {
    Copy-Item -Path $webDir -Destination "$installDir\web" -Recurse -Force
    Write-Host "  OK - Folder web UI disalin." -ForegroundColor Green
}

# Salin signatures jika ada
$sigDir = Join-Path $scriptDir "signatures"
if (Test-Path $sigDir) {
    Copy-Item -Path $sigDir -Destination "$installDir\signatures" -Recurse -Force
    Write-Host "  OK - Database signatures disalin." -ForegroundColor Green
}

Write-Host "  OK - File berhasil diinstall." -ForegroundColor Green
# Salin uninstall helper
$uninstallPs1 = Join-Path $scriptDir "uninstall.ps1"
if (Test-Path $uninstallPs1) {
    Copy-Item -Path $uninstallPs1 -Destination "$installDir\uninstall.ps1" -Force
    $uninstallBat = "@echo off`r`npowershell -ExecutionPolicy Bypass -File `"%~dp0uninstall.ps1`"`r`npause`r`n"
    [System.IO.File]::WriteAllText("$installDir\uninstall.bat", $uninstallBat)
    Write-Host "  OK - Uninstaller disalin ke Program Files." -ForegroundColor Green
}


# ── 5. Buat Free License Otomatis ─────────────────────────
Write-Host ""
Write-Host "[5/6] Membuat lisensi Community (Free) otomatis..." -ForegroundColor Green

$ancamanDataDir = Join-Path $env:USERPROFILE ".ancaman"
if (-not (Test-Path $ancamanDataDir)) {
    New-Item -ItemType Directory -Path $ancamanDataDir -Force | Out-Null
}

$licensePath = Join-Path $ancamanDataDir "license.lic"

$customLic = Join-Path $scriptDir "thinkpad_t410_superadmin_1.lic"
if (-not (Test-Path $customLic)) { $customLic = Join-Path $scriptDir "license.lic" }

if (Test-Path $customLic) {
    Copy-Item $customLic $licensePath -Force
    Write-Host "  OK - Lisensi Enterprise Lifetime Super Admin 1 berhasil dipasang!" -ForegroundColor Green
} elseif (-not (Test-Path $licensePath)) {
    # Generate Hardware ID dari ComputerName + Volume Serial
    $computerName = $env:COMPUTERNAME
    $username = $env:USERNAME
    $volInfo = (Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" -ErrorAction SilentlyContinue).VolumeSerialNumber
    if (-not $volInfo) { $volInfo = "UNKNOWN" }
    
    $hwRaw = "ANCAMAN-HW-$computerName-$username-$volInfo"
    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    $hwBytes = [System.Text.Encoding]::UTF8.GetBytes($hwRaw)
    $hwHash = ($sha256.ComputeHash($hwBytes) | ForEach-Object { $_.ToString("X2") }) -join ""
    $hardwareId = $hwHash.Substring(0, 16)
    
    $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $licenseContent = @{
        version = 1
        payload = @{
            license_id    = "FREE-$hardwareId"
            tier          = "Free"
            hardware_id   = $hardwareId
            customer_name = "Pengguna Ancaman"
            issued_at     = $now
            expires_at    = $null
        }
        signature = "FREE_LICENSE_NO_SIGNATURE_REQUIRED"
    } | ConvertTo-Json -Depth 10

    Set-Content -Path $licensePath -Value $licenseContent -Encoding UTF8
    Write-Host "  OK - Lisensi Community dibuat untuk Hardware ID: $hardwareId" -ForegroundColor Green
    Write-Host "  Untuk upgrade ke Pro, kirimkan Hardware ID di atas ke ancaman.id" -ForegroundColor Cyan
} else {
    Write-Host "  INFO - Lisensi sudah ada, tidak perlu dibuat ulang." -ForegroundColor Yellow
}

# ── 6. Buat Shortcut di Desktop ───────────────────────────
Write-Host ""
Write-Host "[6/6] Membuat shortcut di Desktop..." -ForegroundColor Green

$desktopPath = [Environment]::GetFolderPath("CommonDesktopDirectory")
$shortcutPath = Join-Path $desktopPath "Ancaman Antivirus.lnk"

$shell    = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath       = "$installDir\ancaman-gui.exe"
$shortcut.WorkingDirectory = $installDir
$shortcut.Description      = "Antivirus Ancaman Enterprise"
$shortcut.Save()

Write-Host "  OK - Shortcut dibuat di Desktop." -ForegroundColor Green

# ── 7. Daftarkan Auto-Start saat Windows Boot ─────────────
Write-Host ""
Write-Host "[7/7] Mendaftarkan Auto-Start saat Windows boot..." -ForegroundColor Green

try {
    # 1. Daftarkan di Registry Run (HKLM - untuk semua pengguna mesin)
    $regKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
    $regValue = "`"$installDir\ancaman-gui.exe`" --minimized"
    Set-ItemProperty -Path $regKey -Name "AncamanAntivirus" -Value $regValue -Force
    Write-Host "  OK - Registry Auto-Start terdaftar (HKLM Run)." -ForegroundColor Green
} catch {
    Write-Host "  Peringatan: Gagal menulis Registry Run, menggunakan Startup shortcut..." -ForegroundColor Yellow
}

# 2. Daftarkan di folder Startup Windows (Common Startup)
try {
    $startupFolder = [Environment]::GetFolderPath("CommonStartup")
    if (Test-Path $startupFolder) {
        $startupLnk = Join-Path $startupFolder "Ancaman Antivirus.lnk"
        $startupShortcut = $shell.CreateShortcut($startupLnk)
        $startupShortcut.TargetPath       = "$installDir\ancaman-gui.exe"
        $startupShortcut.Arguments        = "--minimized"
        $startupShortcut.WorkingDirectory = $installDir
        $startupShortcut.Description      = "Ancaman Antivirus Background Protection"
        $startupShortcut.Save()
        Write-Host "  OK - Startup shortcut dibuat di folder Startup Windows." -ForegroundColor Green
    }
} catch {}

# ── Selesai ───────────────────────────────────────────────
Write-Host ""
Write-Host "  =========================================" -ForegroundColor Cyan
Write-Host "   INSTALASI SELESAI!                      " -ForegroundColor Green
Write-Host "  =========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  STATUS SISTEM:" -ForegroundColor White
Write-Host "  -> Auto-Start Windows Boot: AKTIF (Berjalan di System Tray otomatis saat boot)" -ForegroundColor Green
Write-Host "  -> System Tray Icon: AKTIF (Real-Time Protection menjaga di Taskbar)" -ForegroundColor Green
Write-Host ""
Write-Host "  CARA PAKAI:" -ForegroundColor White
Write-Host "  -> Double-click shortcut 'Ancaman Antivirus' di Desktop untuk membuka tampilan" -ForegroundColor Yellow
Write-Host "  -> Klik kanan icon perisai di System Tray taskbar untuk menu cepat" -ForegroundColor Yellow
Write-Host ""

pause

