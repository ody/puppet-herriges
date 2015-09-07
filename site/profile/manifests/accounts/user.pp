##
#
define profile::accounts::user(
  $gecos,
  $groups   = 'users',
  $shell    = '/bin/zsh',
  $dotfiles = true
) {

  $_home = $::kernel ? {
    'Darwin' => "/Users/${name}",
    default  => "/home/${name}",
  }

  user { $name:
    comment => $gecos,
    uid     => '1003',
    shell   => $shell,
    home    => $_home,
  }

  if $dotfiles {
    file { $_home:
      ensure => directory,
      owner  => $name,
      group  => $name,
    }

    file { "${_home}/.dotfiles":
      source  => "puppet:///dropbox/${name}/dotfiles",
      owner   => $name,
      group   => $name,
      recurse => true,
      ignore  => '.git',
    }

    file { "${_home}/.dotfiles/setup":
      source => "puppet:///dropbox/${name}/dotfiles/setup",
      owner  => $name,
      group  => $name,
      mode   => '0700',
    }

    exec { "homedir setup for ${name}":
      command     => "${_home}/.dotfiles/setup",
      path        => '/bin:/usr/bin:/usr/local/bin',
      cwd         => "${_home}/.dotfiles",
      user        => $name,
      environment => "HOME=${_home}",
      subscribe   => File[["${_home}/.dotfiles", "${_home}/.dotfiles/setup"]],
      refreshonly => true,
      provider    => shell,
    }
  }
}
