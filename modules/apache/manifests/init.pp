class apache {
  include apache::install
  include apache::conf
  include apache::sites
  include apache::mods
}

