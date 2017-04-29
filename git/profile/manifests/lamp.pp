#profile/manifests/lamp.pp
class profile::lamp {

  include mysql::server
  include apache

  create_resources('mysql_database', hiera('mysql_database', {}))
  create_resources('apache::vhost', hiera('apache::vhost', {}))
}
