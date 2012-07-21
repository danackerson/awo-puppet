class blogs::successfulengineering {
  # Apache website
  file { "/etc/apache2/sites-available/successfulengineering.com":
      ensure => present,
      owner   => root,
      group   => root,
      mode    => 644,
      source => "puppet:///modules/blogs/etc/apache2/sites-available/successfulengineering.com.conf",
      require => Package["apache"],
      notify => Service["apache"],
  }
  apache::sites::site { "successfulengineering.com" : ensure => present }  
	
  # MySQL DB and USER
  exec { "setup se db":
    path => "/usr/bin",
    unless => "mysql -uroot -p${root_mysql_password} ${se_mysql_db}",
    command => "mysql -uroot -p${root_mysql_password} -e \"\
CREATE DATABASE ${se_mysql_db} DEFAULT CHARACTER SET UTF8;\"",
    require => Exec["set mysql root password"],
  }  
  
  exec { "setup se user":
    path => "/usr/bin",
    unless => "mysql -u${se_mysql_user} -p${se_mysql_pass}",
    command => "mysql -uroot -p${root_mysql_password} -e \"\
CREATE USER '${se_mysql_user}'@'localhost' IDENTIFIED BY '${se_mysql_pass}'; \
GRANT ALL PRIVILEGES ON ${se_mysql_db}.* TO '${se_mysql_user}'@'localhost' WITH GRANT OPTION;\"",
    require => Exec["setup se db"],
  }
  
}