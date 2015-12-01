##
#
class profile::accounts::distributor {

  user { 'distributor':
    comment    => 'A user used to distribute files synced from dropbox',
    uid        => '1002',
    shell      => $::operatingsystem ? {
      'FreeBSD' => '/usr/local/bin/bash',
      default   => '/bin/bash',
    },
    managehome => true,
  }

  ssh_authorized_key { 'ody@orihime':
    user => 'distributor',
    type => 'ssh-ed25519',
    key  => 'AAAAC3NzaC1lZDI1NTE5AAAAIDdp71Z9Vqt8Cua5HIDxXunKkVmZTAYHpDph8ZVymglY',
  }
}
