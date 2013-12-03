class skype {


  # requires Canonical Partner repos, enabled in basic_stuff module

  package { ["lib32z1", "lib32ncurses5", "lib32bz2-1.0"]:
    ensure => present
  }
    
  package { "skype":
    ensure => present, # to keep current with security updates
    require => Package["lib32z1", "lib32ncurses5", "lib32bz2-1.0"]
  }
  
}
