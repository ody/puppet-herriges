##
#
class profile::sudo {

  class { '::sudo':
    purge               => true,
    config_file_replace => true,
  }
  sudo::conf { 'admins':
    priority => 1,
    content  => 'ody ALL=(ALL) NOPASSWD: ALL',
  }
}
