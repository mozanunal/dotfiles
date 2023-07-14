
######## Dev Env ########
dev_all: dev_python dev_data dev_spark
dev_python: install_dev_python install_nodejs
dev_data: install_dev_data install_duckdb
dev_spark: install_dev_scala


###### Dev Environment #####
install_dev_python:
	@echo $(SEP) install_dev_python
	sudo apt install -y -qq python-is-python3 python3-pip ipython3

install_nodejs:
	@echo $(SEP) install_nodejs
	curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
	sudo apt-get install -y nodejs

install_dev_data:
	@echo $(SEP) install_dev_data
	sudo apt install -y -qq sqlite3

install_duckdb:
	@echo $(SEP) install_duckdb
	wget https://github.com/duckdb/duckdb/releases/download/v0.7.1/duckdb_cli-linux-amd64.zip
	unzip duckdb_cli-linux-amd64.zip
	rm duckdb_cli-linux-amd64.zip
	sudo mv duckdb /usr/local/bin

install_dev_scala:
	@echo $(SEP) install_dev_scala
	sudo apt install openjdk-8-jdk
	curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
	chmod +x cs
	./cs setup
	sudo mv ./cs /usr/local/bin

install_dev_spark:
	pip install pyspark




