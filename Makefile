sync_de:
	ansible-playbook --ask-become-pass local.yml

sync_de_dev:
	ansible-playbook -vv --ask-become-pass local.yml

all: sync_de
