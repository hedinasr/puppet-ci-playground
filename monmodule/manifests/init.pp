class monmodule {
  if $osfamily == 'Debian' {
    package { 'lsb-release': ensure => 'installed' }
  }
}
