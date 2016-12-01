create-ssh-known-hosts:
	ssh-keyscan \
		github.com,$$(dig github.com +short | sort -n | paste -s -d ',') \
		bitbucket.org,$$(dig bitbucket.org +short | sort -n | paste -s -d ',') \
		| sort -u \
		> setup-user/ssh_known_hosts

