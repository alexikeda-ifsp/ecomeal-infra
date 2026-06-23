Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-22.04"

  config.vm.hostname = "ecomeal-server"

  config.vm.network "private_network",
    ip: "192.168.56.10"


  config.vm.provider "virtualbox" do |vb|
    vb.name = "ecomeal-server"
    vb.memory = 4096
    vb.cpus = 2
  end


  config.vm.synced_folder ".",
                          "/home/vagrant/ecomeal-workspace"


  # Instala Ansible
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y ansible
  SHELL


  # Executa configuração da VM
  config.vm.provision "ansible_local" do |ansible|

    ansible.playbook = "/home/vagrant/ecomeal-workspace/ansible/playbook.yml"
    ansible.install = true

  end


end