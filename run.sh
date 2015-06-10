#!/bin/bash
if [ ! -f /.root_pw_set ]; then
	/set_root_pw.sh
fi
/etc/init.d/puppet start
hostname $(cat /etc/hosts | awk '{ print $2 }' | head -1)
exec /usr/sbin/sshd -D
