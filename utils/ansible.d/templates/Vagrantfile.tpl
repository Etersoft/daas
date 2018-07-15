# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # config.ssh.username = "vagrant"
  # config.ssh.password = "vagrant"

  config.vm.define "vstand" do |vn|
     vn.vm.box = "{{vstand.vagrant.box.name}}"
     vn.vm.synced_folder ".", "/vagrant", disabled: true
     vn.vm.hostname = "{{ project.vstand.hostname }}"
     vn.vm.network "public_network", :adapter=>2, interface: "dhcp" 
     {%- if vstand.host.pub_interface id defined -%}
       , bridge: "{{vstand.host.pub_interface}}"
     {%- endif -%}
     {% if project.networks is defined -%}
     {%- set adptN = 3 -%}
     {%- set netN = 1 -%}
     {% for netname in project.networks %}
     {%- set net = project.networks[netname] %}
     {% if net.subnet is defined -%}
     vn.vm.network "private_network", :adapter=>{{adptN}}, ip: "{{net.subnet}}.{{project.vstand.ip}}", virtualbox__intnet: "{{project.name}}-net{{netN}}"
     {% set adptN = adptN + 1 -%}
     {% set netN = netN + 1 -%}     
     {% endif -%}
     {% endfor %}
     {%- endif -%}
     vn.vm.provider :virtualbox do |vb|
         vb.gui = false;
         # disable USB
         vb.customize ["modifyvm", :id, "--usb", "off", "--usbehci", "off"]
         {% if vstand.limits.cpu is defined -%}
         vb.customize ["modifyvm", :id, "--cpus",{{vstand.limits.cpu}}];
         {%- endif %}
         {%- if vstand.limits.memory is defined %}
         vb.customize ["modifyvm", :id, "--memory",{{vstand.limits.memory}}];
         {%- endif %}
     end
     vn.vm.provision "shell", path: "bootstrap.sh", args: ""
  end
end
