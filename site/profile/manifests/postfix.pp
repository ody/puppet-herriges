##
#
class profile::postfix(
  String $relay_pw,
  String $relay_user
) {

  class { '::postfix':
    relayhost => '[smtp.gmail.com]:587',
  }

  postfix::config { 'smtp_sasl_auth_enable':      value => 'yes' }
  postfix::config { 'smtp_sasl_password_maps':    value => 'hash:/etc/postfix/sasl_passwd' }
  postfix::config { 'smtp_sasl_security_options': value => 'noanonymous' }
  postfix::config { 'smtp_use_tls':               value => 'yes' }
  postfix::config { 'smtp_tls_CAfile':            value => '/etc/ssl/certs/ca-bundle.crt' }

  postfix::hash { '/etc/postfix/sasl_passwd':
    content => "[smtp.gmail.com]:587        ${relay_user}:${relay_pw}",
  }

  package { 'cyrus-sasl-plain': ensure => present }
}
