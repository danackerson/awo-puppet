class apache::install {
  package { "apache":
    name   => "apache2",
    ensure => latest,
  }
  
  service { "apache":
    name => "apache2",
    enable => true,
    ensure => running,
    hasrestart => true,
    require => Package["apache"],
  }
   
  exec { "force-reload-apache":
    command => "/etc/init.d/apache2 force-reload",
    refreshonly => true,
    before => Service["apache"],
  }
}
