# 🧱 Palo Alto Firewall Backup Script - pa_backup.sh

**Author:** Brandon Filbert  
**License:** [MIT License](./LICENSE)  
**Language:** Bash  
**Purpose:** Automate the backup of Palo Alto firewall configurations via the API.

---

## 📘 Overview

This script automates downloading and archiving configuration backups from one or more Palo Alto Networks firewalls using their API.  
It’s lightweight, dependency-free (only needs `bash` and `curl`), and can be easily scheduled via `cron` or `systemd`.

---

## ⚙️ Requirements

- **Bash** (v4+ recommended)  
- **curl**  
- API access to each firewall  
- An API key for each device (see below)

---

## 🔑 Generate an API Key

Use your browser to generate an API key for each device:

```
https://<firewall-ip>/api/?type=keygen&user=<username>&password=<password>
```

Record the resulting key and add it to the corresponding array element in the script.

---

## 🧰 Configuration

Edit `pa_backup.sh` and update the following arrays with your firewalls’ details:

```bash
pa_names[0]="Branch-PA"
pa_ips[0]="192.168.1.1"
pa_keys[0]="your_api_key_here"
```

You can add multiple firewalls by incrementing the array index (`[1]`, `[2]`, etc.).

Also set your working directory:
```bash
cd /path/to/backup/directory
```

This is where your backup files and logs will be stored.

---

## ▶️ Usage

Make the script executable:
```bash
chmod +x pa_backup.sh
```

Run manually:
```bash
./pa_backup.sh
```

Or schedule it via `cron`:
```bash
0 2 * * * /path/to/pa_backup.sh >/dev/null 2>&1
```
*(Runs daily at 2 AM)*

---

## 🧾 Output

The script downloads and saves configuration files in the working directory:
```
Branch-PA_20240930-040005.xml
HQ-PA_20240930-040009.xml
```

Logs are written to `pa_backup.log` in working directory.

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](./LICENSE) file for details.
