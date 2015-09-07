##
#
class profile {

  include('::profile::accounts')
  include('::profile::sudo')
  include('::profile::ssh')

  package { 'zsh': ensure => present }
}
