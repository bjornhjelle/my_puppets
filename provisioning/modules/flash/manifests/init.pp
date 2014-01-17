class flash {
  # kilde: http://www.if-not-true-then-false.com/2010/install-adobe-flash-player-10-on-fedora-centos-red-hat-rhel/
  exec { "flash-repos":
    command => "rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm",
    path => "/usr/bin",
    unless => "rpm -qa | grep adobe-release-x86_64-1.0-1.noarch"
  }

  exec { "flash-repos-import":
    command => "rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux",
    path => "/usr/bin",
    unless => 'rpm -qi gpg-pubkey | grep "Adobe Systems"',
    require => Exec["flash-repos"]
  }

  package { ["flash-plugin", "nspluginwrapper", "alsa-plugins-pulseaudio", "libcurl"]:
    ensure => 'present',
    require => Exec["flash-repos-import"]
  }
}
