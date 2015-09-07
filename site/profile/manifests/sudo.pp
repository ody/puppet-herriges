##
#
class profile::sudo {

  class { '::sudo':
    purge               => true,
    config_file_replace => true,
  }
  sudo::conf { 'admins':
    priority => 1,
    content  => '%wheel ALL=(ALL) NOPASSWD: ALL',
  }
  sudo::conf { 'vagrant':
    priority => 1,
    content  => 'vagrant ALL=(ALL) NOPASSWD: ALL',
  }
}
