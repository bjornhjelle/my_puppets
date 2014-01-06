




#class virtualbox {
#  file { "/etc/yum.repos.d/virtualbox.repo":
#    ensure => file,
#    source => "/home/bjorn/my_puppets/files/virtualbox.repo",
#  }

#  package { "VirtualBox":
#    ensure => 'present',
#    require => File["/etc/yum.repos.d/virtualbox.repo"]
#  }
#  user {
#  "bjorn":
#      groups      => ["vboxusers"],
#      membership => minimum,
#      require => Package["VirtualBox"]
#  }  
#  
#  exec { "kmod-VirtualBox":
#    command => "systemctl restart systemd-modules-load.service",
#    require => Package["VirtualBox"],
#    path => "/bin",
#  }
  
#}


#define install_group ($group = $title) {
#  exec { "group install ${group}":
#    unless  => "/usr/bin/yum grouplist \"${group}\" | /bin/grep \"^Installed Groups\"",
#    command => "/usr/bin/yum  groupinstall \"${group}\""
#  }
#}

#exec { "update":
#  command => "yum -y update",
#  path => "/usr/bin",
#}

node default {

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  }
  

  
  package { ["git", "git-gui", "tcplay", "keepassx", "gnupg", "wget", "vlc", "gedit-plugins", "easytag"]:
    ensure => 'present'
  }


  class { "basic_stuff":
    hostname => "htpc"
  }
  include flash
  include dropbox
  include google-chrome
  include virtualbox
  include mpd
  include spotify

  # en annen spotify rpm:
  #https://docs.google.com/file/d/0B_UAut69TSAicTFDU01QOVlXc2s/edit?usp=sharing



#  exec {"vagrant":
#    command => "yum -y install http://files.vagrantup.com/packages/db8e7a9c79b23264da129f55cf8569167fc22415/vagrant_1.3.3_x86_64.rpm",
#    path => "/usr/bin",
#    unless => "rpm -qa | grep vagrant",
#    require => Package["VirtualBox"]
#  }
}

#  Not very elegant, but it's a work around
#exec { 'yum Group Install':
#  unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"',
#  command => '/usr/bin/yum -y groupinstall "Development tools"',
#}

#install_group {'Games and Entertainment': 
#  require => Exec["update"]
#}

#exec { "games_and_entertainment":
#  command => '/usr/bin/yum -y groupinstall "Games and Entertainment"',
#  require => Exec["update"]
#}

