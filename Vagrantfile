Vagrant.configure("2") do |config|
    # Disable vbguest auto update if plugin present
    if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = false
    end
  
    # Variables
    WEB_IP     = "192.168.56.10"
    DB_IP      = "192.168.56.20"
    DB_PORT    = 3307
    GITHUB_URL = "https://github.com/startbootstrap/startbootstrap-clean-blog.git"
  
    # Web server (Ubuntu)
    config.vm.define "web-server" do |web|
      web.vm.box = "ubuntu/jammy64"
      web.vm.hostname = "web-server"
      web.vm.network "public_network"
      web.vm.network "private_network", ip: WEB_IP
  
      # We don’t need synced_folder overriding /var/www/html,
      # because GitHub clone will handle it
      # web.vm.synced_folder "./website", "/var/www/html"
  
      web.vm.provision "shell", path: "scripts/provision-web-ubuntu.sh", args: [GITHUB_URL]
    end
  
    # DB server (CentOS)
    config.vm.define "db-server" do |db|
      db.vm.box = "generic/centos9s"
      db.vm.hostname = "db-server"
      db.vm.network "private_network", ip: DB_IP
      db.vm.network "forwarded_port", guest: 3306, host: DB_PORT
      db.vm.provision "shell", path: "scripts/provision-db-centos.sh"
    end
  end
  