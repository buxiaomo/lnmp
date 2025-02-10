SHELL := /bin/bash

runtime:
	@curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
	@mkdir -p /etc/docker
	@cp conf/daemon.json /etc/docker/daemon.json
	@systemctl enable docker.service
	@systemctl restart docker.service

deploy:
	@docker stack deploy -c stack.yml lnmp --with-registry-auth --prune --detach=false

fix:
	# 101 nginx 33 php
	@chown -R 33.101 ./data/www
	@find ./data/www -type d -exec chmod 755 {} \;
	@find ./data/www -type f -exec chmod 644 {} \;