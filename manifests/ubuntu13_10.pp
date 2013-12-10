

class spotify {
  
  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


  exec { 'add spotify':
    command => 'sudo add-apt-repository "deb http://repository.spotify.com stable non-free"',
  }
    
  exec { 'add spotify key':
    command => 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59',
    require => Exec['add spotify']
  }        
  
  exec { 'update':
    command => 'apt-get update',
    require => Exec['add spotify key']
  }
      
  package { 'spotify-client' :
    ensure => 'present',
    provider => 'apt',
    require => Exec['update']
  }
}
  


node default {

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  }
  
  include basic_stuff
  include spotify 
  include nas_mounts
  include skype
  

}
