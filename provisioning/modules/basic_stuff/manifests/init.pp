class basic_stuff($hostname) {

  file { "/etc/hosts":
    ensure => file,
    owner => root,
    group => root,
    source => "puppet:///modules/basic_stuff/hosts_$hostname",
  }
  
  file { "/home/bjorn/.bash_aliases":
    ensure => file,
    owner => root,
    group => root,
    source => "puppet:///modules/basic_stuff/bash_aliases",
  }

  package { ["git", "git-gui", "tcplay", "keepassx", "gnupg", "gedit-plugins", "vlc", "liveusb-creator", "wget", "easytag"]:
    ensure => present,
  }


# Dropbox

  file { "/etc/yum.repos.d/dropbox.repo":
    ensure => file,
    source => "puppet:///modules/basic_stuff/dropbox.repo",
  }

  file { "/etc/sysctl.conf":
    ensure => file,
    source => "puppet:///modules/basic_stuff/sysctl.conf",
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
