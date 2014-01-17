class nrk {

  package { ["ffmpeg", "php", "mkvtoolnix",  "perl-Text-Iconv",  "perl-HTML-TokeParser-Simple", "php-bcmath"]:
    ensure => present
  }

  file { "/home/bjorn/bin" :
    source => "puppet:///modules/nrk/bin",
    recurse => true
  }

}
