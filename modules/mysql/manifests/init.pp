class mysql {
  package { "mysql-server":
    ensure => latest,
  }

  package { "libmysqlclient-dev":
    ensure => latest,
  }

  service { "mysql":
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package["mysql-server"], 
  }

  exec { "set mysql root password":
    path => "/usr/bin",
    unless => "mysql -uroot -p${root_mysql_password}",
    command => "mysqladmin -u root password ${root_mysql_password}",
    require => Service['mysql'],
  }
  
  file { "/etc/mysql/my.cnf":
    ensure => present,
    content => template("mysql/my.cnf.erb"),
    notify => Service["mysql"],
    require => Package["mysql-server"],
  }

}
