

class flash {
# kilde: http://www.if-not-true-then-false.com/2010/install-adobe-flash-player-10-on-fedora-centos-red-hat-rhel/
exec { "flash-repos":
  command => "rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm",
  path => "/usr/bin",
  require => Exec["update"],
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


class dropbox {
file { "/etc/yum.repos.d/dropbox.repo":
  ensure => file,
  source => "/home/bjorn/nas/bjorn/puppet/files/dropbox.repo",
}

file { "/etc/sysctl.conf":
  ensure => file,
  source => "/home/bjorn/nas/bjorn/puppet/files/sysctl.conf",
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

class google-chrome {
file { "/etc/yum.repos.d/google-chrome.repo":
  ensure => file,
  source => "/home/bjorn/nas/bjorn/puppet/files/google-chrome.repo",
}

package { "google-chrome-stable":
  ensure => 'present',
  require => File["/etc/yum.repos.d/google-chrome.repo"]
}
}

#define install_group ($group = $title) {
#  exec { "group install ${group}":
#    unless  => "/usr/bin/yum grouplist \"${group}\" | /bin/grep \"^Installed Groups\"",
#    command => "/usr/bin/yum  groupinstall \"${group}\""
#  }
#}

exec { "update":
  command => "yum -y update",
  path => "/usr/bin",
}


package { ["git", "git-gui", "tcplay", "keepassx", "gnupg", "wget", "vlc"]:
  ensure => 'present',
  require => Exec["update"]
}


include flash
include dropbox
include google-chrome

exec { "spotify":
  command => "yum -y install http://trash.ulyaoth.asia/trash/rpm/spotify-client-0.9.1.55.ulyaoth-1.fc19.x86_64.rpm",
  path => "/usr/bin",
}


#  Not very elegant, but it's a work around
#exec { 'yum Group Install':
#  unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"',
#  command => '/usr/bin/yum -y groupinstall "Development tools"',
#}

#install_group {'Games and Entertainment': 
#  require => Exec["update"]
#}

#exec { "games_and_entertainment":
#  command => '/usr/bin/yum -y groupinstall "Games and Entertainment"',
#  require => Exec["update"]
#}

