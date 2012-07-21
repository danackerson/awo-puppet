class apache::mods {
  define mods_stats ( $ensure = 'present') {
    case $ensure {
      'present' : {
        exec { "/usr/sbin/a2enmod $name":
          unless => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/$name.load ] \\
            && [ /etc/apache2/mods-enabled/${name}.load -ef /etc/apache2/mods-available/${name}.load ]'",
            notify => Exec["force-reload-apache"],
 	    require => Package["apache"],
        }
      }
      'absent': {
        exec { "/usr/sbin/a2dismod $name":
          onlyif => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/${name}.load ] \\
            && [ /etc/apache2/mods-enabled/${name}.load -ef /etc/apache2/mods-available/${name}.load ]'",
            notify => Exec["force-reload-apache"],
            require => Package["apache"],
        }
      }
      default: { err ( "Unknown ensure value: '$ensure'" ) }
    }
  }

  apache::mods::mods_stats { 
    "rewrite" : ensure => present, 
    notify => Service["apache"], 
  }

  apache::mods::mods_stats { 
    "deflate" : ensure => present, 
    notify => Service["apache"], 
  }

  apache::mods::mods_stats { 
    "headers" : ensure => present, 
    notify => Service["apache"],
  }

  apache::mods::mods_stats { 
    "expires" : ensure => present, 
    notify => Service["apache"], 
  }

}

