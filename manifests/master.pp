class ntp::master inherits ntp {
	Ntp::Server["/etc/ntp.conf"] {
		config => "server",
	}
}

# vim: tabstop=3