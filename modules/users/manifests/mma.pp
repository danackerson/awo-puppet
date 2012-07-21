class users::matthias {

  user { "matthias":
    ensure => present,
    shell => "/bin/bash",
    groups => ["adm", "root"],
  }

  file { [ "/home/matthias", "/home/matthias/.ssh" ] :
    ensure => directory,
    owner => "matthias",
    mode => 600,
    require => User["matthias"],
  }

  ssh_authorized_key { "matthias":
    ensure  => present,
    key     => 'xyz',
    type    => 'ssh-dss',
    user    => 'matthias',
    require => File["/home/matthias/.ssh"],    
  }

}