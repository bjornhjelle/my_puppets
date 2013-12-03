

class flash {
  # kilde: http://www.if-not-true-then-false.com/2010/install-adobe-flash-player-10-on-fedora-centos-red-hat-rhel/
  exec { "flash-repos":
    command => "rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm",
    path => "/usr/bin",
    unless => "rpm -qa | grep adobe-release-x86_64-1.0-1.noarch"

  }
  exec { "flash-repos-import":
    command => "rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux",
    path => "/usr/bin",
    unless => 'rpm -qi gpg-pubkey | grep "Adobe Systems"',
    require => Exec["flash-repos"]
  }

  package { ["flash-plugin", "nspluginwrapper", "alsa-plugins-pulseaudio", "libcurl"]:
    ensure => 'present',
    require => Exec["flash-repos-import"]
  }
}


class dropbox {
  file { "/etc/yum.repos.d/dropbox.repo":
    ensure => file,
    source => "/home/bjorn/my_puppets/files/dropbox.repo",
  }

  file { "/etc/sysctl.conf":
    ensure => file,
    source => "/home/bjorn/my_puppets/files/sysctl.conf",
  }

  package { "nautilus-dropbox":
    ensure => 'present',
    require => File["/etc/yum.repos.d/dropbox.repo"]
  }
  exec { "sysctl-p":
    command => "sysctl -p",
    path => "/usr/sbin",
    require => File["/etc/sysctl.conf"]
  }
}

class google-chrome {
  file { "/etc/yum.repos.d/google-chrome.repo":
    ensure => file,
    source => "/home/bjorn/my_puppets/files/google-chrome.repo",
  }

  package { "google-chrome-stable":
    ensure => 'present',
    require => File["/etc/yum.repos.d/google-chrome.repo"]
  }
}

class virtualbox {
  file { "/etc/yum.repos.d/virtualbox.repo":
    ensure => file,
    source => "/home/bjorn/my_puppets/files/virtualbox.repo",
  }

  package { "VirtualBox":
    ensure => 'present',
    require => File["/etc/yum.repos.d/virtualbox.repo"]
  }
  user {
  "bjorn":
      groups      => ["vboxusers"],
      membership => minimum,
      require => Package["VirtualBox"]
  }  
  
  exec { "kmod-VirtualBox":
    command => "systemctl restart systemd-modules-load.service",
    require => Package["VirtualBox"],
    path => "/bin",
  }
  
}


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
  
  file { "/home/bjorn/.bashrc":
    ensure => file,
    source => "/home/bjorn/my_puppets/files/bashrc",
    mode => 644 
  }

  package { ["git", "git-gui", "tcplay", "keepassx", "gnupg", "wget", "vlc", "gedit-plugins"]:
    ensure => 'present',
    require => File["/home/bjorn/.bashrc"]
  }


  include flash
  include dropbox
  include google-chrome
  include virtualbox

  # en annen spotify rpm:
  #https://docs.google.com/file/d/0B_UAut69TSAicTFDU01QOVlXc2s/edit?usp=sharing

  exec { "spotify":
    command => "yum -y install http://trash.ulyaoth.asia/trash/rpm/spotify-client-0.9.1.55.ulyaoth-1.fc19.x86_64.rpm",
    path => "/usr/bin",
    unless => "rpm -qa | grep spotify-client"

  }

  exec {"vagrant":
    command => "yum -y install http://files.vagrantup.com/packages/db8e7a9c79b23264da129f55cf8569167fc22415/vagrant_1.3.3_x86_64.rpm",
    path => "/usr/bin",
    unless => "rpm -qa | grep vagrant",
    require => Package["VirtualBox"]


  }
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

