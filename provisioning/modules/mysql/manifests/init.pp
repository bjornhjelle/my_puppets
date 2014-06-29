class mysql {

  exec { "mysql repos":
    command => "yum -y localinstall http://dev.mysql.com/get/mysql-community-release-fc20-5.noarch.rpm"    
  }
  
  package { ["php", "php-mysqlnd", "mysql-community-server"]:
    ensure => installed,
    require => Exec['mysql repos']
  }

  
#  file { "/etc/mysql/my.cnf":
#    owner => root,
#    group => root,  
#    mode => 644,
#    source => "puppet:///modules/mysql/my.cnf"
#  }
  
  exec {"mysqld":
    command => "chkconfig mysqld on; systemctl start mysqld",
    require => Package["mysql-community-server"]
  }


#http://bitfieldconsulting.com/puppet-and-mysql-create-databases-and-users
  exec { 
    "mysql_password":
      unless => "mysqladmin -uroot -proot status",
      command => "mysqladmin -uroot password root",
      require => Exec["mysqld"];
    "wordpress_db":
      unless => "mysql -uroot -proot wordpress_db",
      command => "mysql -uroot -proot -e 'create database wordpress_db'",
      require => Exec["mysql_password"];
    "wordpress":
      unless => "mysql -uwordpress -phemmelig wordpress_db",
      command => "mysql -uroot -proot -e \"GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER,LOCK TABLES ON wordpress_db.* TO wordpress@localhost IDENTIFIED BY 'hemmelig'; FLUSH PRIVILEGES\"",
#      command => "mysql -uroot -p$mysql_password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",     
      require => Exec["wordpress_db"];    
  }  
  
}


