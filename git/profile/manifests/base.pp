class profile::base {

  include ntp
  class { 'motd':
    content => "This is host ${::fqdn}."
  }

  create_resources('user', hiera_hash('user', {}))
}
