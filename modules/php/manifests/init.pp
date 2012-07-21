class php {
  package {
    "php5": 
      ensure => present;
    "curl": 
      ensure => present;
    "xml-core": 
      ensure => present;
    "php5-curl": 
      ensure => present;
    "imagemagick":
      ensure => present;
    "php5-xsl": 
      ensure => present,
      notify => Service["apache"];
    "php-apc": 
      ensure => present,
      notify => Service["apache"];
    "php5-gd": 
      ensure => present,
      notify => Service["apache"];
    "php5-mysql": 
      ensure => present,
      notify => Service["apache"];
    "libapache2-mod-php5": 
      ensure => present,
      notify => Service["apache"];
  }

  file { "/etc/php5/apache2/php.ini":
    ensure => present,
    mode => 644,
    content => template("php/etc/php5/conf.d/php.ini.erb"),
    require => Package["php5"],
    notify => Service["apache"];
  }
  
  file { "/etc/php5/apache2/apc.ini":
    ensure => present,
    mode => 644,
    content => template("php/etc/php5/conf.d/apc.ini.erb"),
    require => [ Package["php5"], Package["php-apc"], Package["apache"] ],
    notify => Service["apache"];
  }
}
