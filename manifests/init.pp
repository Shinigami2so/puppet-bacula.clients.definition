# bacula_client_def
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include bacula_client_def
class bacula_client_def {

# Create client config directory
file { '/etc/bacula/clientdefs/':
ensure => directory,
owner  => root,
group  => root,
mode   => '0755',
}


# Array of client names to loop through and create file with each iteration
['hrm', 'backups2', 'vm1', 'vm2'].each |String $value| {
$fd_name = $value
# Create config files in the director server
file { "/etc/bacula/clientdefs/${fd_name}-fd.conf":
ensure  => file,
require => File['/etc/bacula/clientdefs/'],
content => epp('bacula_client_def/client-template.conf.epp', { 'fd' => $value }),
mode    => '0755',
owner   => root,
group   => root,
}
}

}
