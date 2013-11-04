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
    
  package { ["gedit-plugins", "git-gui", "flashplugin-installer", "vlc"]:
    ensure => present
  }
  
  exec { "get dropbox":
    command => 'wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb',
    cwd => '/home/bjorn/Downloads',
    user => 'bjorn',
    group => 'bjorn',
    creates => '/home/bjorn/Downloads/dropbox_1.6.0_amd64.deb'
  }

  exec { "install dropbox":
    command => 'dpkg -i dropbox*.deb',
    cwd => '/home/bjorn/Downloads',
    user => 'bjorn',
    group => 'bjorn',
    creates => '/home/bjorn/Downloads/dropbox_1.6.0_amd64.deb'
  }
  
}
