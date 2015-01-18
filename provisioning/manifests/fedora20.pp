
node 'hp' {
  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  }
  
  package { ["inkscape",  "kernel-devel", "gimp", "transmission", "dvdauthor", "ffmpeg", "brasero", "texlive", "latex2html",
             "pandoc", "autoconf", "bison", "rdesktop", "sqlite", "sqlite-devel",
              "poedit", # for wordpress språkfiler
              "java-1.7.0-openjdk-devel",
              "devilspie"
             ]:
    ensure => present
  }
    
  include basic_stuff
  include vagrant
  include mysql
  include pipelight
  include vpn
}

node 'htpc.localdomain' {

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  }


  include basic_stuff
  include vpn
  include flash
  include dropbox
  include google-chrome
  #include virtualbox
  include mpd
  include spotify
  include xbmc
  #include netflix
  #include apache
  include nrk  

  include pipelight
  # en annen spotify rpm:
  #https://docs.google.com/file/d/0B_UAut69TSAicTFDU01QOVlXc2s/edit?usp=sharing




}





