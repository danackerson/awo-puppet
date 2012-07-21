class ntp {
  package { 'ntp':
    ensure => latest
  }
  
  service { 'ntp':
    ensure  => running,
    enable  => true,
    require => File['ntp.conf'],
    notify => Exec["timezone"],
  }
  
  file { 'ntp.conf':
    ensure  => file,
    path    => '/etc/ntp.conf',
    require => Package['ntp'],
    notify => Service['ntp'],
    content => template('ntp/ntp.conf.erb'),
  }

  exec { 'timezone':
    command => "/bin/rm -f /etc/localtime; /bin/ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime",
    refreshonly => true,
  }
}