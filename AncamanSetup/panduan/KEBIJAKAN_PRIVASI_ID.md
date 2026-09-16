# KEBIJAKAN PRIVASI — ANCAMAN ANTIVIRUS & CYBER DEFENSE

**Tanggal Efektif:** September 2026  
**Prinsip Utama:** Privasi Tanpa Kompromi & Pemrosesan Lokal Mandiri

---

### 1. Pengantar & Komitmen Privasi
Ancaman Antivirus memprioritaskan kerahasiaan dan privasi pengguna. Berbeda dengan antivirus konvensional yang kerap mengunggah data pengguna ke server luar negeri, **Ancaman beroperasi dengan arsitektur pemrosesan lokal (Air-Gapped First)**. Seluruh berkas, dokumen, dan aktivitas komputasi Anda tetap berada di komputer Anda sendiri.

### 2. Data yang Diproses Sistem
Untuk menjalankan fungsi proteksi dan aktivasi lisensi offline, aplikasi hanya memproses:
* **Hardware Machine ID (HWID):** Hash satu arah SHA-256 yang dibuat dari nama komputer dan nomor seri drive lokal. Nilai hash ini tidak dapat didekripsi balik menjadi data sensitif.
* **Log Deteksi Ancaman:** Ketika virus terdeteksi, sistem hanya mencatat lokasi berkas, hash SHA-256 virus, nama varian ancaman, dan waktu deteksi ke dalam database lokal komputer Anda (`C:\Program Files\Ancaman\database\`).
* **Token Lisensi:** Tanda tangan digital kriptografis Ed25519 untuk memvalidasi status lisensi secara offline.

### 3. Data yang TIDAK PERNAH Diambil
Ancaman Antivirus **TIDAK PERNAH** membaca, merekam, atau menyebarkan:
* ❌ Dokumen pribadi (Word, Excel, PDF, Berkas Teks)
* ❌ Foto, video, atau rekaman suara pribadi
* ❌ Riwayat penjelajahan browser (*history*), cookies, atau data sesi
* ❌ Tombol ketikan keyboard (*keystroke logging*) atau rekaman layar
* ❌ Password akun, token perbankan, atau kredensial rahasia pengguna

### 4. Keamanan Brankas Karantina
Setiap berkas berbahaya yang diisolasi ke dalam Penjara Virus (Karantina) dienkripsi menggunakan standar keamanan militer **AES-256-GCM**. Kunci enkripsi disimpan aman hanya di komputer lokal Anda, sehingga pihak lain atau pihak luar tidak dapat mengakses maupun mengekstrak muatan tersebut.

### 5. Kepatuhan Hukum & Regulasi
Kebijakan ini tunduk dan patuh sepenuhnya pada:
* **Undang-Undang Republik Indonesia No. 27 Tahun 2022** tentang Perlindungan Data Pribadi (UU PDP).
* **Kerangka Kerja Keamanan Siber Badan Siber dan Sandi Negara (BSSN CSF)**.
* **Standar Manajemen Keamanan Informasi ISO/IEC 27001:2022**.

---
*Layanan bantuan privasi: security@ancaman.id*
