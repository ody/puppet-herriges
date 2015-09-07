##
#
class profile::accounts {

  pe_accounts::user {'distributor':
    comment => 'A user used to distribute files synced from dropbox',
    uid     => '1002',
    gid     => '1002',
    sshkeys => ['ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDdp71Z9Vqt8Cua5HIDxXunKkVmZTAYHpDph8ZVymglY ody@orihime'],
  }
}
