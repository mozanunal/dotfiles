sync_dev:
	ansible-playbook dev.yml

sync_de:
	ansible-playbook local.yml

all: sync_de
