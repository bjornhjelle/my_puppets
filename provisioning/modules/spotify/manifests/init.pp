class spotify {

# http://blog.ulyaoth.net/2012/03/01/spotify-for-linux-preview-installation-in-fedora/


  file { "/etc/yum.repos.d/ulyaoth.repo":
    ensure => file,
    source => "puppet:///modules/spotify/ulyaoth.repo",
  }

  exec { "spotify":
    command => "yum -y install spotify",
    path => "/usr/bin",
    unless => "rpm -qa | grep spotify"

  }

}
