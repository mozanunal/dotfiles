
######## Dev Env ########
all: install_dev_data install_dev_scala

###### Dev Environment #####
install_example_data:
	@echo $(SEP) install_example_data
	rm -rf ~/.data
	cp -r data/ ~/.data

install_dev_data:
	@echo $(SEP) install_dev_data
	sudo apt install -y -qq \
		python-is-python3 \
		python3-pip
	brew install \
		sqlite \
		litecli \
		duckdb \
		ipython \
		pyright \
		datasette \
		marksman
	pip install \
		pandas \
		pyspark

install_dev_scala:
	@echo $(SEP) install_dev_scala
	sudo apt install openjdk-8-jdk
	brew install coursier
	cs setup
	cs install metals

install_dev_lua:
	@echo $(SEP) install_dev_lua
	brew install lua-language-server

