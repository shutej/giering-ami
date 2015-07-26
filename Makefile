PACKER_VERSION := 0.8.2

.PHONY: validate ami

validate: packer_bin/packer
	packer_bin/packer validate -var-file=aws.json ami.json

ami: ami.json packer_bin/packer
	PACKER_LOG=1 PACKER_LOG_PATH=ami.log time packer_bin/packer build -var-file=aws.json $<

packer_bin/packer_bin.zip:
	mkdir -p $(shell dirname $@)
	curl -L 'https://dl.bintray.com/mitchellh/packer/$(PACKER_VERSION)_'$(shell uname | tr '[:upper:]' '[:lower:]')'_amd64.zip' -o $@

packer_bin/packer: packer_bin/packer_bin.zip
	unzip -o -q $^ -d packer_bin
	touch $@
