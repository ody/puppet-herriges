##
#
class profile {

  include('::profile::accounts')

  package { 'zsh': ensure => present }
}
