##
#
class profile::gitlab(String $hostname) {

  class { '::gitlab':
    external_url   => "https://${hostname}",
    service_enable => true,
    nginx          => {
      redirect_http_to_https => true,
      listen_addresses       => ['*', '[::]']
    }
  }
}
