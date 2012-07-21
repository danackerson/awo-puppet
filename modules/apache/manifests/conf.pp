class apache::conf {
	
  file { "/etc/apache2/apache2.conf":
    ensure => present,
    owner   => root,
    group   => root,  
    mode    => 440,   
    source => "puppet:///modules/apache/etc/apache2/apache2.conf",
    notify => Service["apache"],
  }
   
  file { "/etc/apache2/httpd.conf":
    ensure => present,
    owner   => root,
    group   => root,  
    mode    => 440,   
    source => "puppet:///modules/apache/etc/apache2/httpd.conf",
    notify => Service["apache"],
  }
  
}
