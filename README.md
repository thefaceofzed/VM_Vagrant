# 🚀 Simple DevOps Infra Project with Vagrant

This project provisions a **two-VM environment** using Vagrant:

- **Web Server**: Ubuntu 22.04 with Nginx serving a [StartBootstrap Clean Blog](https://github.com/startbootstrap/startbootstrap-clean-blog) template.
- **DB Server**: CentOS Stream 9 with MySQL 8 installed and pre-loaded with a demo database.

## 📂 Project Structure

.
├── Vagrantfile
├── scripts/
│ ├── provision-web-ubuntu.sh
│ └── provision-db-centos.sh
└── website/ # optional local site folder



## ⚙️ Requirements

- [VirtualBox](https://www.virtualbox.org/) (7.x)
- [Vagrant](https://developer.hashicorp.com/vagrant) (2.4+)
- [Git](https://git-scm.com/)

## ▶️ Usage

1. Clone this repo:
   ```bash
   git clone https://github.com/<your-username>/<your-repo>.git
   cd <your-repo>
Start the VMs:


vagrant up
Access the web server:

Open http://192.168.56.10 in your browser

You should see the Clean Blog website

Access the database from host:

bash

mysql -h 127.0.0.1 -P 3307 -u devuser -pdevpass -D demo_db
🛠️ Provisioning Details
Web Server (web-server)

Ubuntu 22.04 (ubuntu/jammy64)

Installs nginx and git

Clones the Clean Blog repo into /var/www/html

Automatically starts and enables nginx

DB Server (db-server)

CentOS Stream 9 (generic/centos9s)

Installs MySQL 8

Creates database demo_db and user devuser/devpass

Forwards MySQL port 3306 → host 3307

🧹 Cleanup
To stop and remove the VMs:

vagrant destroy -f
📌 Notes
Ensure VirtualBox Guest Additions match your VirtualBox version.

If you see 403 Forbidden, make sure files from dist/ are copied into /var/www/html.

✍️ Maintained by Ismail El farouki



---

👉 Want me to also include a **demo SQL file (`create-table.sql` + `insert-demo-data.sql`)** in the repo so MySQL always l
