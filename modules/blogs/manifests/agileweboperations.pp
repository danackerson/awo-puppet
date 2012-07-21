class blogs::agileweboperations {
  # Apache website
  file { "/etc/apache2/sites-available/agileweboperations.com":
      ensure => present,
      owner   => root,
      group   => root,
      mode    => 644,
      source => "puppet:///modules/blogs/etc/apache2/sites-available/agileweboperations.com.conf",
      require => Package["apache"],
      notify => Service["apache"],
  }
  apache::sites::site { "agileweboperations.com" : ensure => present }  

  # MySQL DB and USER
  exec { "setup awo db":
    path => "/usr/bin",
    unless => "mysql -uroot -p${root_mysql_password} ${awo_mysql_db}",
    command => "mysql -uroot -p${root_mysql_password} -e \"\
CREATE DATABASE ${awo_mysql_db} DEFAULT CHARACTER SET UTF8;\"",
    require => Exec["set mysql root password"],
  }  
  
  exec { "setup awo user":
    path => "/usr/bin",
    unless => "mysql -u${awo_mysql_user} -p${awo_mysql_pass}",
    command => "mysql -uroot -p${root_mysql_password} -e \"\
CREATE USER '${awo_mysql_user}'@'localhost' IDENTIFIED BY '${awo_mysql_pass}'; \
GRANT ALL PRIVILEGES ON ${awo_mysql_db}.* TO '${awo_mysql_user}'@'localhost' WITH GRANT OPTION;\"",
    require => Exec["setup awo db"],
  }
 
}