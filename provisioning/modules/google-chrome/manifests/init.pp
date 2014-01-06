class google-chrome {
  file { "/etc/yum.repos.d/google-chrome.repo":
    ensure => file,
    source => "puppet:///modules/google-chrome/google-chrome.repo",
  }

  package { "google-chrome-stable":
    ensure => 'present',
    require => File["/etc/yum.repos.d/google-chrome.repo"]
  }
}
