##
# Sets up systemd logind
class logind(
    $handlepowerkey = 'poweroff',
    $handlesuspendkey = 'suspend',
    $handlehibernatekey = 'hibernate',
    $handlelidswitch = 'suspend',
    $handlelidswitchdocked = 'ignore',
) {
    file { '/etc/systemd/logind.conf':
        ensure  => 'file',
        content => template('logind/logind.conf.erb'),
        require => File['/etc/systemd/system/puppet-run.timer'],
        notify  =>  Exec['restart systemd-logind']
    }

    exec { 'restart systemd-logind':
        command     => 'systemctl restart systemd-logind',
        refreshonly => true,
        path        => ['/usr/bin', '/bin']
    }
}
