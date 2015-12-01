##
#
class profile {

  include('::profile::accounts')
  include('::profile::sudo')
  include('::profile::ssh')

  class { '::ntp':
    servers => [
      '0.north-america.pool.ntp.org',
      '1.north-america.pool.ntp.org',
      '2.north-america.pool.ntp.org',
      '3.north-america.pool.ntp.org',
    ]
  }

  package { ['bash', 'zsh']: ensure => present }
}
