class apache {

  package { ["httpd"]:
    ensure => present,
    before => File["/etc/httpd/conf/httpd.conf"]
  }

  service {
    "httpd":
       ensure => true,
       enable => true,
       require => Package["httpd"],
       subscribe => [File["/etc/httpd/conf/httpd.conf"], Package["httpd"]]
  }
  
  file {
    "/etc/httpd/conf/httpd.conf":
       source => "puppet:///modules/apache/httpd.conf",
       mode => 644,
       owner => root,
       group => root,
       require => Package["httpd"],
       notify => Service["httpd"],
  }
  
  exec { "restart httpd":
    command => "systemctl enable httpd.service",
    require => File["/etc/httpd/conf/httpd.conf"]  
  }

}
