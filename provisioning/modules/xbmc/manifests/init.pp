class xbmc {

  package { ["xbmc"]:
    ensure => present
  }

  file { ["/home/bjorn/.xbmc", "/home/bjorn/.xbmc/userdata"] :
    ensure => directory,
    owner => bjorn,
    group => bjorn    
  }

  file { "advancedsettings.xml":
    path => "/home/bjorn/.xbmc/userdata/advancedsettings.xml",
    ensure => file,
    owner => root,
    group => root,
    source => "puppet:///modules/xbmc/advancedsettings.xml",
    require => [Package["xbmc"], File["/home/bjorn/.xbmc/userdata"]]
  }  
    

}
