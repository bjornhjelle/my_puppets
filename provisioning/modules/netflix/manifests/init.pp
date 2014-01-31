class netflix {


#sjekk heller denne: 

#http://fds-team.de/cms/articles/2013-08/pipelight-using-silverlight-in-linux-browsers.html
#http://fds-team.de/cms/pipelight-installation.html



  # https://ask.fedoraproject.org/en/answers/15637/revisions/

  # http://forums.fedoraforum.org/showthread.php?t=286230


  package { ["libpng15", "cabextract"]:
   ensure => present
  }

  exec { "wine":
    command => "yum -y install http://sourceforge.net/projects/postinstaller/files/fedora/releases/19/x86_64/updates/wine-silverligh-1.7.2-1.fc19.x86_64.rpm",
    require => [Package["xbmc"], Package["libpng15"]],
    unless => 'rpm -qa | grep "wine-silverligh"',
  } 

  exec { "netflix":
    command => "yum -y install http://sourceforge.net/projects/postinstaller/files/fedora/releases/19/x86_64/updates/netflix-desktop-0.7.0-7.fc19.noarch.rpm",
    require => Exec["wine"],
    unless => 'rpm -qa | grep "netflix-desktop"',
  }

}
