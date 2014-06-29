class basic_stuff {

#  file { "/home/bjorn/.bash_aliases":
#    ensure => file,
#    owner => root,
#    group => root,
#    source => "puppet:///modules/basic_stuff/bash_aliases",
#  }

  file { "/etc/profile.d/alias_h.sh":
    ensure => file,
    owner => root,
    group => root,
    source => "puppet:///modules/basic_stuff/alias_h.sh",
  }

  package { ["openssh-server", "openssh"]:
    ensure => present
  }

  service {"sshd":
    ensure => true,
    enable => true,
    require => Package["openssh-server"]
  }

  package { ["git-gui", "tcplay", "ftp", "gnupg", "gedit-plugins", "vlc", "liveusb-creator", "wget", "easytag", "icedtea-web", "eog", "smplayer"]:
    ensure => present
  }

  package { ["libXv.i686", "libXScrnSaver.i686", "qt.i686", "qt-x11.i686",  "pulseaudio-libs.i686", "pulseaudio-libs-glib2.i686", "alsa-plugins-pulseaudio.i686"]:
    ensure => present,
    require => Package["wget"]
  }

  exec { "skype":
    command => "yum -y install /home/bjorn/nas/bjorn/programvare/skype/skype-4.2.0.11-fedora.i586.rpm",
    unless => "rpm -qa | grep skype",
    require => Package["libXv.i686"]
  }
  
  exec { "virtualbox":
    command => "yum -y install /home/bjorn/nas/bjorn/programvare/virtualbox/VirtualBox-4.3-4.3.6_91406_fedora18-1.x86_64.rpm",
    unless => "rpm -qa | grep VirtualBox",
    require => Package["dkms"]
  }
#  exec { "virtualbox extension pack":
#    command => "vboxmanage extpack install ~/nas/bjorn/programvare/virtualbox/Oracle_VM_VirtualBox_Extension_Pack-4.3.6-91406.vbox-extpack",
#    unless => "vboxmanage list extpacks | grep 'Oracle VM VirtualBox Extension Packssdf'",
#    require => Exec["virtualbox"]
#  }  

  package { ["glibc.i686", "system-config-printer"]:
    ensure => present,
    require => Package["wget"]
  }

  exec { "brother":
    command => "yum -y install /home/bjorn/nas/bjorn/programvare/brother/cupswrapperHL2270DW-2.0.4-2.i386.rpm /home/bjorn/nas/bjorn/programvare/brother/hl2270dwlpr-2.1.0-1.i386.rpm",
    unless => "rpm -qa | grep hl2270dwlpr",
    require => Package["glibc.i686"]
  }


  
#  exec { 'dropbox_update':
#    command => 'apt-get update',
#    require => Exec['add spotify key']
#  }
       
  
#  file { "/etc/apt/sources.list.d/dropbox.list":
#    owner => "root",
#    group => "root",
#    mode => 444,
#    source => "puppet:///modules/basic_stuff/dropbox.list",
#    require => Exec["add dropbox key"]
#  }  
  
}
