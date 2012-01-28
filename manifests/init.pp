class ntp {
	define ntp::server ($config = false, $local = false, $remote = false) {
		file { "$name":
			owner   => root,
			group   => root,
			mode    => 0644,
			alias   => "ntp",
			content => template("ntp/common/etc/ntp-${config}.conf.erb"),
			notify  => Service["ntp"],
			require => Package["ntp"],
		}
	}

	ntp::server { "/etc/ntp.conf":
		config => "client",
		local  => [
			"ntp1.${::domain}",
			"ntp2.${::domain}",
			"ntp3.${::domain}"
		],
		remote => [
			"0.pool.ntp.org",
			"1.pool.ntp.org",
			"2.pool.ntp.org",
			"3.pool.ntp.org"
		],
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

# vim: tabstop=3