ID ?= 0

run:
	docker run -d -i -t --name="devenv-$(ID)" \
		-v="$$HOME/.ssh/id_rsa:/root/.ssh/id_rsa" \
		-v="$$PWD:/root/devenv" \
		-p="808$(ID):808$(ID)" \
		-p="606$(ID):606$(ID)" \
		leighmcculloch/devenv \
		|| docker start devenv-$(ID)
	docker ps
	docker attach --detach-keys="ctrl-a,d" devenv-$(ID) || true
	docker ps

clean:
	docker stop devenv-$(ID) || true
	docker rm devenv-$(ID) || true

build:
	docker build . -t leighmcculloch/devenv

pull:
	docker pull leighmcculloch/devenv
