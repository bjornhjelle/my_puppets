class basic_stuff {

  file { "/etc/hosts":
    ensure => file,
    owner => root,
    group => root,
    source => "puppet:///modules/basic_stuff/hosts",
  }
  
  file { "/home/bjorn/.bash_aliases":
    ensure => file,
    owner => root,
    group => root,
    source => "puppet:///modules/basic_stuff/bash_aliases",
  }

# Funker ikke å installere dropbox fra repository. Så installerer slik: 
# $ cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
# $ ~/.dropbox-dist/dropboxd

  # Add Dropbox's apt-key.
  # Assumes definition elsewhere of an Exec["apt-get update"] - or
  # uncomment below.
#  exec { "add dropbox key":
#    command => "apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E",
#    refreshonly => true,
#    notify => Exec["update"],
#  }   
  
    
  package { ["gedit-plugins", "git-gui", "flashplugin-installer", "vlc"]:
    ensure => present,
#    require => Exec["dropbox_update"]
  }

  file { "/etc/sysctl.d/dropbox.conf":
    ensure => file,
    owner => root,
    group => root,
    source => "puppet:///modules/basic_stuff/dropbox.conf",
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
