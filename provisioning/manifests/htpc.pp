
node default {

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  }


  include basic_stuff
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





