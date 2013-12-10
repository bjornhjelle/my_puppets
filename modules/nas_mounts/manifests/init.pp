class nas_mounts {
      
  include secrets  

  package { 'cifs-utils' :
    ensure => 'present',
    provider => 'apt',
    require => Exec['update']
  }
   
  file { '/etc/cifspwd':
    ensure => file,
    content => template('nas_mounts/cifspwd.erb')
  }
  
  exec { 'add mounts to fstab':
    command => 'echo '
  }

  mount { "/mnt/nas_music":
    device  => "//nas/music",
    fstype  => "cifs",
    ensure  => "mounted",
    options => "iocharset=utf8,credentials=/etc/cifspwd,rw,uid=bjorn,gid=users",
    atboot  => true,
    require => File["/etc/cifspwd"]
  }

  mount { "/mnt/nas_video":
    device  => "//nas/video",
    fstype  => "cifs",
    ensure  => "mounted",
    options => "iocharset=utf8,credentials=/etc/cifspwd,rw,uid=bjorn,gid=users",
    atboot  => true,
    require => File["/etc/cifspwd"]
  }
  
  mount { "/mnt/nas":
    device  => "//nas/backed_up",
    fstype  => "cifs",
    ensure  => "mounted",
    options => "iocharset=utf8,credentials=/etc/cifspwd,rw,uid=bjorn,gid=users",
    atboot  => true,
    require => File["/etc/cifspwd"]
  }  
  
  file {"/home/bjorn/nas":
    ensure => link,
    target => "/mnt/nas",
    require => Mount["/mnt/nas"]
  } 

  file {"/home/bjorn/nas_music":
    ensure => link,
    target => "/mnt/nas_music",
    require => Mount["/mnt/nas_music"]
  } 
  
  file {"/home/bjorn/nas_video":
    ensure => link,
    target => "/mnt/nas_video",
    require => Mount["/mnt/nas_video"]
  }   
  
}
