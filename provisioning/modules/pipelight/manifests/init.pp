class pipelight {

  package { "cabextract":
    ensure => present
  }

  exec { "msfonts" :
    command =>  "rpm -i http://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm",
    unless => "rpm -qa | grep msttcore-fonts-installer-2.6-1",
    require => Package["cabextract"]
  }

  exec { "pipelight-repos" :
    command =>  "wget http://download.opensuse.org/repositories/home:/DarkPlayer:/Pipelight/Fedora_20/home:DarkPlayer:Pipelight.repo -O /etc/yum.repos.d/pipelight.repo",
    unless => "ls /etc/yum.repos.d/pipelight.repo",
    require => Package["cabextract"]
  }
  
  package { "pipelight":
    ensure => present,
    require => Exec["pipelight-repos"]
  }
  
  exec { "pipelight-update" :
    command =>  "pipelight-plugin --update ",
    require => Package["pipelight"]
  }


  exec { "widewine" :
    command =>  "pipelight-plugin --accept --enable widevine ",
    require => Package["pipelight"]
  }
  
  
  notify{"run: pipelight-plugin --enable widevine": 
    require => Exec["widewine"]
  }
  
  exec { "setsebool" :
    command =>  "setsebool -P unconfined_mozilla_plugin_transition 0",
    require => Exec["widewine"]
  }
  
}
