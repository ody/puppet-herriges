##
#
class profile::accounts {

  include('::profile::accounts::distributor')
  Class['::profile::accounts::distributor'] -> Class['::profile::accounts']

  profile::accounts::user { 'ody':
    gecos  => 'Cody Herriges',
    groups => ['users', 'wheel'],
    shell  => $::operatingsystem ? {
      'FreeBSD' => '/usr/local/bin/zsh',
      default   => '/bin/zsh',
    },
  }
}
