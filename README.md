# 🌩️ CloudScan - Automated Cloud Port Scanner

`cloud-scan.sh` is a Bash script designed to automate port scanning for common cloud services like EC2, RDS, Kubernetes, Docker, Load Balancers, and more. It uses `nmap` to perform targeted scans based on the service type you specify.

---

## 🚀 Features

- Predefined port sets for major cloud services
- Simple interface: just provide target and service type
- Saves results in all standard Nmap formats
- Supports full TCP port scan mode
- Built-in help and validation

---

## 🧰 Requirements

- Bash (Linux or macOS)
- [Nmap](https://nmap.org/) installed and accessible in your `$PATH`

---

## ⚙️ Usage

```bash
./cloud-scan.sh <target-ip-or-hostname> <service-type>
