class spotify {

  exec { "spotify":
    command => "yum -y install http://trash.ulyaoth.asia/trash/rpm/spotify-client-0.9.1.55.ulyaoth-1.fc19.x86_64.rpm",
    path => "/usr/bin",
    unless => "rpm -qa | grep spotify-client"

  }

}
