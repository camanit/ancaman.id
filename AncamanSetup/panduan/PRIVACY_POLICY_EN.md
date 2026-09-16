# PRIVACY POLICY — ANCAMAN ANTIVIRUS & CYBER DEFENSE

**Effective Date:** September 2026  
**Commitment:** Zero-Knowledge Local Processing & Strict User Sovereignty

---

### 1. Introduction & Core Principle
Ancaman Antivirus is committed to protecting your personal privacy. Unlike legacy security software that constantly streams personal user files to foreign cloud servers, **Ancaman operates on an offline-first architecture**. Your files, privacy, and system activity remain strictly on your machine.

### 2. Information We Collect
To operate the endpoint protection and offline licensing mechanisms, the Software only processes:
* **Hardware Machine ID (HWID):** A one-way SHA-256 cryptographic hash derived from the local computer name and volume serial number. It is mathematically impossible to reverse this hash to obtain sensitive hardware info.
* **Malicious Telemetry Logs:** When malware or a suspicious file is detected, only the file path, SHA-256 hash, virus signature classification, and detection timestamp are recorded in the local database (`C:\Program Files\Ancaman\database\`).
* **License Payload:** Cryptographic Ed25519 token used solely to verify feature entitlements locally.

### 3. What We DO NOT Collect
Ancaman Antivirus **NEVER** accesses, reads, logs, or transmits:
* ❌ Personal documents (Word, Excel, PDF, Text files)
* ❌ Personal photos, videos, or audio recordings
* ❌ Browser browsing history, cookies, or saved sessions
* ❌ Keystrokes, chat messages, or screen recordings
* ❌ Passwords, encryption keys, or financial credentials

### 4. Quarantine Vault Security
Files identified as malicious and isolated into the Quarantine Vault are encrypted using **AES-256-GCM**. The decryption keys are generated and held exclusively on the local machine node. No external party or cloud service has access to your quarantine vault.

### 5. Regulatory Compliance
This Privacy Policy strictly complies with:
* **Undang-Undang No. 27 Tahun 2022** tentang Perlindungan Data Pribadi (UU PDP Indonesia).
* **BSSN Cyber Security Framework (CSF)** for Endpoint Telemetry Isolation.
* **ISO/IEC 27001:2022** Information Security Controls.

### 6. Updates to Policy
Any updates to this policy will be documented with revision notices in application changelogs and documentation.

---
*For privacy inquiries: security@ancaman.id*
