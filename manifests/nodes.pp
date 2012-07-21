node default {
  include setenv
  include ntp
  
  include users
  
  include mysql
  include apache
  include php
  
  include blogs
}
