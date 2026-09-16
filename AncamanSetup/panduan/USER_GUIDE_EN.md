# USER GUIDE — ANCAMAN ANTIVIRUS ENTERPRISE

Welcome to **Ancaman Antivirus**, Indonesia's Sovereign Cyber Defense & Endpoint Protection Platform built in Rust.

---

### 1. Installation & Setup
1. Extract `AncamanSetup.zip` into any directory.
2. Right-click **`Setup.bat`** and select **"Run as Administrator"**.
3. The installer will automatically:
   * Stop any running background instances.
   * Install the latest binaries to `C:\Program Files\Ancaman\`.
   * Configure **Auto-Start on Boot** (so Ancaman runs automatically when your laptop starts up).
   * Initialize the **System Tray Icon** in the taskbar.
   * Detect pre-bundled licenses (e.g. ThinkPad Super Admin) or create a Community license.
   * Create the **Ancaman Antivirus** desktop shortcut.

---

### 2. Auto-Start & System Tray Operation
* **When your computer boots:** Ancaman starts silently in the background with real-time kernel protection active. A blue shield icon appears in your Windows Taskbar System Tray.
* **Left-Click Tray Icon:** Opens the Ancaman Antivirus dashboard.
* **Right-Click Tray Icon:** Provides quick options:
  * 🛡️ *Buka Ancaman Antivirus* (Open Dashboard)
  * ❌ *Keluar* (Exit Application & stop background protection)
* **Closing the Window:** Clicking the **[X]** button on the top-right does **not** stop the antivirus; it minimizes to the System Tray to maintain 24/7 protection.

---

### 3. File & Threat Inspection (Scanner)
Navigate to the **File Scanner** tab in the sidebar:
* **Quick Scan:** Rapidly checks vulnerable system areas (Downloads, Desktop, Temp) for malware payloads.
* **Full System Scan:** Thoroughly analyzes the entire `C:\` drive with YARA-X heuristic rules.
* **Custom Directory Scan:** Enter or select any folder path to run an on-demand audit.
* **Quarantine:** If threats are detected, click **"Quarantine All Threats"** to safely isolate them with AES-256-GCM encryption into the Quarantine Vault.

---

### 4. Quarantine Vault Management
Navigate to the **Quarantine Vault** tab:
* **Isolated Files:** Displays all neutralized malware with original file paths, detection signatures, and quarantine timestamps.
* **Restore:** Restores a false-positive file back to its original location.
* **Shred Permanently:** Securely removes the malicious file with multi-pass zero-fill overwrite.

---

### 5. License Activation
* Your **Hardware Machine ID** is displayed under the **License** tab.
* To activate a Pro or Enterprise license, submit your Hardware ID to your administrator to receive an authorized `.lic` file.
* Open the `.lic` file in Notepad, copy its content, paste it into the activation field, and click **"Activate License"**.

---

### 6. System Requirements
* **OS:** Windows 10, Windows 11, or Windows 7 SP1 (64-bit).
* **Runtime:** Microsoft WebView2 Runtime (included natively in modern Windows; software-rendering fallback enabled for older GPUs and VMs).
* **RAM:** Minimum 512 MB available RAM (ultra-lightweight Rust engine).

---
*Support & Documentation: https://ancaman.id • support@ancaman.id*
