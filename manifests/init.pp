class ntp {
	define ntp::server ($config = false, $local = false, $remote = false) {
		file { "$name":
			owner   => root,
			group   => root,
			mode    => 0644,
			alias   => "ntp",
			content => template("ntp/etc/ntp-${config}.conf.erb"),
			notify  => Service["ntp"],
			require => Package["ntp"],
		}
	}

	ntp::server { "/etc/ntp.conf":
		config => "client",
		local  => hiera_array('local'),
		remote => hiera_array('remote'),
	}

	package { "ntp":
		ensure => present,
	}

	service { "ntp":
		enable     => true,
		ensure     => running,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			File["ntp"],
			Package["ntp"]
		],
	}
}

