class profile::base {
  class { '::ntp': }
  class { '::monmodule': }
}
