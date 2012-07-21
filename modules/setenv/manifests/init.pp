class setenv {
	
  package { sudo: ensure => latest }
	
  package { htop : ensure => latest }
  
  package { unzip : ensure => latest }
  
  package { git-core: ensure => latest }
  
  package { vim : ensure => latest }
  
  package { fail2ban : ensure => latest }

  exec { "/usr/sbin/update-alternatives --set editor /usr/bin/vim.basic":
    unless => "/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic"
  }
  
  file { "/etc/environment":
    ensure => present,
    content => template("setenv/etc/environment.erb"),
  }

}
