# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :ami do |box|
    box.vm.box = "ubuntu/trusty64"

    box.ssh.insert_key = false
    box.ssh.forward_agent = true

    box.vm.network :private_network,
      ip: "192.168.21.11"

    box.vm.provision :shell,
      privileged: false,
      inline:     "(cd /vagrant && ./provision.sh)"

    box.vm.provider :virtualbox do |v|
      v.memory = 1048
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    box.vm.provider :aws do |aws, override|
      aws.access_key_id = ENV['AWS_KEY']
      aws.secret_access_key = ENV['AWS_SECRET']
      aws.keypair_name = ENV['AWS_KEYNAME']

      aws.ami = "ami-5c207736"
      aws.instance_type = "t2.micro"
      aws.region = ENV['AWS_REGION']

      aws.terminate_on_shutdown = true

      override.vm.box = "dummy"
      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = ENV['AWS_KEYPATH']
    end
  end
end
