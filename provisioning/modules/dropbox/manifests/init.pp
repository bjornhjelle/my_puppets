class dropbox {

# Dropbox

  file { "/etc/yum.repos.d/dropbox.repo":
    ensure => file,
    source => "puppet:///modules/basic_stuff/dropbox.repo",
  }

  file { "/etc/sysctl.conf":
    ensure => file,
    source => "puppet:///modules/basic_stuff/sysctl.conf",
  }

  package { "nautilus-dropbox":
    ensure => 'present',
    require => File["/etc/yum.repos.d/dropbox.repo"]
  }
  exec { "sysctl-p":
    command => "sysctl -p",
    path => "/usr/sbin",
    require => File["/etc/sysctl.conf"]
  }
}
