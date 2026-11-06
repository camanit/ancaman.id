/*
 * ANCAMAN ANTIVIRUS — YARA Rules: Ransomware
 * Versi: 1.0.0
 * Update: 2026-07-16
 *
 * Rules untuk mendeteksi ransomware — musuh utama Ancaman!
 * "Kami adalah Ancaman bagi semua ransomware!"
 */

// ─────────────────────────────────────────
// GENERIC RANSOMWARE PATTERNS
// ─────────────────────────────────────────

rule ANCAMAN_Ransomware_Generic {
    meta:
        description = "Pola umum ransomware — enkripsi file + tuntutan tebusan"
        author      = "Ancaman Team"
        severity    = "critical"
        category    = "ransomware"

    strings:
        // Pesan tebusan umum
        $msg1   = "your files have been encrypted"    ascii nocase wide
        $msg2   = "files are encrypted"               ascii nocase wide
        $msg3   = "decrypt your files"                ascii nocase wide
        $msg4   = "pay the ransom"                    ascii nocase wide
        $msg5   = "restore your files"                ascii nocase wide
        $msg6   = "YOUR FILES ARE LOCKED"             ascii nocase wide

        // Ekstensi file yang ditambahkan ransomware
        $ext1   = ".locked"    ascii nocase
        $ext2   = ".encrypted" ascii nocase
        $ext3   = ".crypted"   ascii nocase
        $ext4   = ".crypt"     ascii nocase
        $ext5   = ".enc"       ascii nocase

        // Kontak pembayaran
        $pay1   = "bitcoin"    ascii nocase wide
        $pay2   = ".onion"     ascii nocase wide
        $pay3   = "BTC"        ascii
        $pay4   = "monero"     ascii nocase wide

    condition:
        (any of ($msg*)) or
        (2 of ($ext*) and any of ($pay*)) or
        (any of ($msg*) and any of ($pay*))
}

rule ANCAMAN_Ransomware_FileEncryption {
    meta:
        description = "Pola enkripsi file masif — deteksi behavioral"
        author      = "Ancaman Team"
        severity    = "critical"
        category    = "ransomware"

    strings:
        // Crypto API yang dipakai ransomware
        $crypt1 = "CryptEncrypt"       ascii wide
        $crypt2 = "CryptGenKey"        ascii wide
        $crypt3 = "CryptAcquireContext" ascii wide
        $crypt4 = "BCryptEncrypt"      ascii wide
        $crypt5 = "BCryptGenerateSymmetricKey" ascii wide

        // Volume Shadow Copy deletion (favorit ransomware)
        $vsc1   = "vssadmin delete shadows"         ascii nocase
        $vsc2   = "wmic shadowcopy delete"          ascii nocase
        $vsc3   = "bcdedit /set {default}"          ascii nocase
        $vsc4   = "wbadmin delete catalog"          ascii nocase

        // Ransom note filenames
        $note1  = "READ_ME"            ascii nocase
        $note2  = "HOW_TO_DECRYPT"     ascii nocase
        $note3  = "DECRYPT_INSTRUCTIONS" ascii nocase
        $note4  = "YOUR_FILES.txt"     ascii nocase
        $note5  = "RANSOM_NOTE"        ascii nocase

    condition:
        (2 of ($crypt*) and any of ($note*)) or
        any of ($vsc*) or
        (any of ($vsc*) and any of ($crypt*))
}

rule ANCAMAN_Ransomware_WannaCry {
    meta:
        description = "WannaCry Ransomware — salah satu yang paling terkenal"
        author      = "Ancaman Team"
        severity    = "critical"
        category    = "ransomware"
        reference   = "CVE-2017-0144 (EternalBlue)"

    strings:
        $wc1    = "WannaCry"           ascii wide nocase
        $wc2    = "WNCRY"              ascii
        $wc3    = "wanakiwi"           ascii nocase
        $wc4    = ".WNCRY"             ascii
        $wc5    = "WannaDecryptor"     ascii wide nocase
        $wc6    = "tasksche.exe"       ascii
        $mutex  = "Global\\MsWinZonesCacheCounterMutexA" ascii

    condition:
        2 of them
}

rule ANCAMAN_Ransomware_LockBit {
    meta:
        description = "LockBit Ransomware — ransomware-as-a-service berbahaya"
        author      = "Ancaman Team"
        severity    = "critical"
        category    = "ransomware"

    strings:
        $lb1    = "Lockbit_ransom_note" ascii nocase
        $lb2    = ".lockbit"           ascii nocase
        $lb3    = "restore-my-files.txt" ascii nocase
        $lb4    = "lockbit3.0"          ascii nocase

    condition:
        uint16(0) == 0x5A4D and any of them
}

rule ANCAMAN_Ransomware_Ryuk {
    meta:
        description = "Ryuk Ransomware — target perusahaan besar"
        author      = "Ancaman Team"
        severity    = "critical"
        category    = "ransomware"

    strings:
        $r1     = "RyukReadMe"         ascii nocase
        $r2     = ".ryk"               ascii nocase
        $r3     = "No system is safe"  ascii nocase
        $r4     = "Ryuk Ransomware"    ascii nocase

    condition:
        uint16(0) == 0x5A4D and any of them
}

rule ANCAMAN_Ransomware_Conti {
    meta:
        description = "Conti Ransomware — kelompok APT Rusia"
        author      = "Ancaman Team"
        severity    = "critical"
        category    = "ransomware"

    strings:
        $c1     = "CONTI"              ascii nocase
        $c2     = ".CONTI"             ascii nocase
        $c3     = "conti_readme"       ascii nocase
        $c4     = "HOW_TO_CONTACT_US"  ascii nocase wide

    condition:
        2 of them
}
