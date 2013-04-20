class house::sudo {

  include ::sudo
  sudo::rule { "ody_no_passwd":
    ensure   => present, 
    who      => 'ody', 
    commands => 'ALL',
    nopass   => true,
    comment  => 'I am lazy',
  }
}
