class users::dan {

  user { "dan":
    ensure => present,
    shell => "/bin/bash",
    groups => ["adm", "root"],
  }

  file { [ "/home/dan", "/home/dan/.ssh" ] :
    ensure => directory,
    owner => "dan",
    mode => 600,
    require => User["dan"],
  }

  ssh_authorized_key { "dan":
    ensure  => present,
    key     => 'abc',
    type    => 'ssh-dss',
    user    => 'dan',
    require => File["/home/dan/.ssh"],    
  }

}