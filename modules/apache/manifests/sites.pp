class apache::sites {
  define site ( $ensure = 'present', $content = '' ) {
    case $ensure {
      'present' : {
        exec { "/usr/sbin/a2ensite $name":
          unless => "/bin/sh -c '[ -L /etc/apache2/sites-enabled/$name ] \\
            && [ /etc/apache2/sites-enabled/$name -ef /etc/apache2/sites-available/$name ]'",
          notify => Service["apache"],
        }
      }
      'absent' : {
      	exec { "/usr/sbin/a2dissite $name":
          onlyif => "/usr/bin/test -h /etc/apache2/sites-enabled/$name",
      	  notify => Service["apache"],
        }
      }
      default: { err ( "Unknown ensure value: '$ensure'" ) }
    }
  }
  
  apache::sites::site { "000-default" : ensure => absent }
  apache::sites::site { "default-ssl" : ensure => absent }
}
 
 




  
