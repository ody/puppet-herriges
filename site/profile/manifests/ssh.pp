##
#
class profile::ssh {

  class { '::ssh::server':
    storeconfigs_enabled => true,
    options              => {
      'PasswordAuthentication'          => 'no',
      'ChallengeResponseAuthentication' => 'no',
      'PubkeyAuthentication'            => 'yes',
      'PermitRootLogin'                 => 'without-password',
      'Port'                            => 22,
      'KexAlgorithms'                   => 'curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256',
      'Ciphers'                         => 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr',
      'MACs'                            => 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com',
      'Protocol'                        => '2',
      'HostKey'                         => [ '/etc/ssh/ssh_host_ed25519_key', '/etc/ssh/ssh_host_rsa_key' ],
      'AllowGroups'                     => [ 'users', 'vagrant' ],
    }
  }

  exec { 'secure moduli':
    command  => 'awk \'$5 > 2000\' /etc/ssh/moduli > /etc/ssh/moduli.secure',
    unless   => '[ \'0\' -eq `awk \'$5 <= 2000\' /etc/ssh/moduli | wc -l` ]',
    provider => shell,
  }

  file { '/etc/ssh/moduli':
    source  => '/etc/ssh/moduli.secure',
    owner   => '0',
    group   => '0',
    mode    => '0644',
    require => Exec['secure moduli'],
  }

  exec { 'secure rsa host key':
    command  => 'rm /etc/ssh/ssh_host_rsa_key && ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key </dev/null',
    unless   => 'ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key | grep 4096',
    provider => shell,
  }
}
