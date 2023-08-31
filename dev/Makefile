
######## Dev Env ########
all: install_dev_data install_dev_scala install_dev_lua

###### Dev Environment #####
install_dev_data:
	@echo $(SEP) install_dev_data
	sudo apt install -y -qq \
		python-is-python3 \
		python3-pip \
		python3-venv
	python -m venv .venv/
	. .venv/bin/activate && \
		pip install -r requirements.txt
	brew install \
		duckdb \
		pyright \
		marksman

install_dev_scala:
	@echo $(SEP) install_dev_scala
	sudo apt install openjdk-8-jdk
	brew install coursier
	cs setup
	cs install metals

install_dev_lua:
	@echo $(SEP) install_dev_lua
	brew install lua-language-server

