class mpd {
  
  package { ["mpd", "mpc", "gmpc"]:
    ensure => 'present'
  }
  
  file { ['/home/bjorn/.mpd', '/home/bjorn/.mpd/.playlists', '/home/bjorn/.config/autostart']:
    ensure => directory,    
    owner  => "bjorn",
    group  => "bjorn"
  }
  
  file { '/home/bjorn/.mpd/mpd.conf':
    ensure => file,
    source => "puppet:///modules/mpd/mpd.conf",
    require => File['/home/bjorn/.mpd']
  } 
  
  
  file { ['/home/bjorn/.mpd/mpd.db', '/home/bjorn/.mpd/mpd.log', '/home/bjorn/.mpd/mpd.pid', '/home/bjorn/.mpd/mpdstate']:
    ensure => file,    
    owner  => "bjorn",
    group  => "bjorn",
    require => File['/home/bjorn/.mpd']
  }

  file { '/home/bjorn/.config/autostart/mpd.desktop':
    ensure => file,
    source => "puppet:///modules/mpd/mpd.desktop",
    require => Package['mpd']
  } 

  alert("husk å åpne for TCP på port 6600 i brannmuren...")
  

}
