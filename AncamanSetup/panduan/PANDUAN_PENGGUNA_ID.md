# PANDUAN PENGGUNA — ANCAMAN ANTIVIRUS ENTERPRISE

Selamat datang di **Ancaman Antivirus**, Platform Pertahanan Siber & Proteksi Endpoint Kedaulatan Indonesia yang dibangun dengan bahasa pemrograman Rust.

---

### 1. Panduan Instalasi
1. Ekstrak file `AncamanSetup.zip` ke folder mana saja di komputer Anda.
2. Klik kanan file **`Setup.bat`** lalu pilih **"Run as Administrator"**.
3. Installer akan bekerja secara otomatis:
   * Menghentikan instans lama jika ada.
   * Memasang file aplikasi ke `C:\Program Files\Ancaman\`.
   * Mendaftarkan **Auto-Start saat Windows Boot** (komputer hidup langsung terlindungi).
   * Memasang **System Tray Icon** di area taskbar Windows.
   * Memasang lisensi otomatis (Enterprise ThinkPad jika tersedia, atau Community Free).
   * Membuat shortcut **Ancaman Antivirus** di Desktop Anda.

---

### 2. Auto-Start & Penggunaan System Tray
* **Saat Komputer / Laptop Dinyalakan:** Ancaman otomatis berjalan di latar belakang menjaga sistem secara real-time. Icon perisai biru akan muncul di System Tray (sudut kanan bawah taskbar dekat jam).
* **Klik Kiri Icon Tray:** Membuka dashboard utama Ancaman Antivirus.
* **Klik Kanan Icon Tray:** Menampilkan menu cepat:
  * 🛡️ *Buka Ancaman Antivirus* (Membuka jendela dashboard)
  * ❌ *Keluar* (Menutup aplikasi dan menghentikan background service)
* **Menutup Jendela (Tombol [X]):** Mengklik tombol silang [X] tidak akan mematikan antivirus, melainkan meminimalkan aplikasi ke System Tray agar laptop tetap terlindungi 24 jam nonstop.

---

### 3. Pemindaian Berkas & Deteksi Virus (Scanner)
Buka tab **Pemindaian Berkas (File Scanner)** pada menu sidebar:
* **Pemindaian Cepat (Quick Scan):** Memeriksa folder yang paling rentan (Downloads, Desktop, Temp) dari muatan virus/malware.
* **Pemindaian Penuh (Full Scan):** Memeriksa seluruh harddisk `C:\` secara mendalam dengan aturan heuristik YARA-X.
* **Pemindaian Folder Khusus:** Masukkan alamat folder yang ingin Anda periksa secara mandiri.
* **Karantina Otomatis:** Jika ditemukan virus, klik tombol **"Karantina Semua Ancaman"** untuk mengamankannya ke Penjara Virus dengan enkripsi AES-256-GCM.

---

### 4. Manajemen Penjara Virus (Quarantine Vault)
Buka tab **Penjara Virus (Quarantine Vault)**:
* **Daftar Berkas Terisolasi:** Menampilkan seluruh file berbahaya yang telah dinetralisir, lengkap dengan tanggal dan lokasi asalnya.
* **Pulihkan (Restore):** Mengembalikan berkas jika terdeteksi salah sasaran (*false positive*).
* **Hancurkan Permanen (Shred):** Menghapus berkas berbahaya secara tuntas dengan metode penimpaan biner (*zero-fill overwrite*).

---

### 5. Aktivasi Lisensi
* Buka tab **Lisensi (License)** untuk melihat **Hardware Machine ID** komputer Anda.
* Untuk aktivasi lisensi Pro atau Enterprise, serahkan Hardware ID ke administrator Anda untuk diterbitkan file lisensi resmi (`.lic`).
* Buka file lisensi dengan Notepad, salin seluruh kodenya, tempel pada kolom aktivasi, lalu klik **"Aktivasi Lisensi"**.

---

### 6. Kebutuhan Sistem
* **Sistem Operasi:** Windows 10, Windows 11, atau Windows 7 SP1 (64-bit).
* **Komponen:** Microsoft WebView2 Runtime (bawaan Windows; aman digunakan di kartu grafis lama dan VMware berkat fitur Safe Software Rendering).
* **Memori:** Minimal 512 MB RAM (sangat ringan dan hemat daya berkat teknologi Rust).

---
*Layanan Dukungan & Bantuan: https://ancaman.id • support@ancaman.id*
