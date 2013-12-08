# simple apache based web server with php and mysql

include augeasproviders
include sysctl

# defaults
Exec        { path => '/usr/sbin:/sbin:/bin:/usr/bin' }
Sshd_config { notify => Service[ 'sshd' ] }
User        { managehome => true }

$packages = ['vi' ]

package { $packages:
    ensure => absent,
}

file { '/etc/profile.d/aliases.sh':
    owner  => 'root', group => 'root', mode => '0644',
    source => 'puppet:///modules/configs/aliases.sh',
    tag    => 'setup',
}

service { 'sshd':
    ensure => 'running',
    enable => 'true',
}


# sshd config
#
sshd_config { 'LoginGraceTime':
    value  => '30s',
}

sshd_config { 'AllowTcpForwarding':
    value => 'yes',
}

sshd_config { 'PermitRootLogin':
    value  => 'yes',
}

sshd_config { 'AllowUsers':
    value  => [ 'root', 'vagrant' ],
}

sshd_config { 'MaxAuthTries':
    value  => '3',
}

sshd_config { 'PasswordAuthentication':
    value  => 'yes',
}

class { 'elasticsearch': 
    package_url => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.0.Beta2.noarch.rpm',
    java_install => true,
     config                   => {
    'cluster'            => {
       'name'             => 'Schibsted_lol'
       },
     'node'                 => {
       'name'               => "node${::ipaddress}"
     },
     'index'                => {
       'number_of_replicas' => '1',
       'number_of_shards'   => '5'
     },
     'network'              => {
       'host'               => $::ipaddress
     }
   }
}

 elasticsearch::plugin{'mobz/elasticsearch-head':
   module_dir => 'head'
 }

 elasticsearch::plugin{'karmi/elasticsearch-paramedic':
 module_dir => 'paramedic'
}

# Setup sudo
file { 'sudo_wheel':
    tag     => 'setup',
    path    => '/etc/sudoers.d/99_wheel',
    owner   => 'root', group => 'root', mode => '0440',
    content => "%wheel ALL = (ALL) ALL\n",
}

augeas { 'sudo_include_dir':
    tag     => 'setup',
    context => '/files/etc/sudoers',
    changes => 'set #includedir "/etc/sudoers.d"',
}

#include oracle_java