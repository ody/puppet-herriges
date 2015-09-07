##
#
class profile::accounts {

  include('::profile::accounts::distributor')
  Class['::profile::accounts::distributor'] -> Class['::profile::accounts']

  profile::accounts::user { 'ody':
    gecos  => 'Cody Herriges',
    groups => ['users', 'wheel'],
  }
}
