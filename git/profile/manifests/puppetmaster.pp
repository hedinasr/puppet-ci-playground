class profile::puppetmaster {

  # Configure puppetdb and its underlying database
  class { 'puppetdb': }
  # Configure the Puppet master to use puppetdb
  class { 'puppetdb::master::config': }

  class { 'puppetexplorer':
    port => '8080',
  }

  # Setup R10k
  class { 'r10k':
      remote => 'http://root:12345678@gitlab/control.git',
  }
}
