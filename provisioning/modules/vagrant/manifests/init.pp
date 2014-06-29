class vagrant {

#  file { "/etc/yum.repos.d/virtualbox.repo":
#    ensure => file,
#    source => "puppet:///modules/vagrant/virtualbox.repo",
#  }

#  package { "VirtualBox":
#    ensure => 'present',
#    require => File["/etc/yum.repos.d/virtualbox.repo"]
#  }

#  user {"bjorn":
#    groups      => ["vboxusers"],
#    membership => minimum,
#    require => Package["VirtualBox"]
#  }  
#  
#  exec { "kmod-VirtualBox":
#    command => "systemctl restart systemd-modules-load.service",
#    require => Package["VirtualBox"]
#  }

  # http://ttboj.wordpress.com/2013/12/09/vagrant-on-fedora-with-libvirt/
  
  exec {"vagrant":
    command => "yum -y install http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.rpm",
    unless => "rpm -qa | grep vagrant"
    #require => Package["VirtualBox"]
  }
  
}
