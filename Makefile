export PROJECT := $(shell pwd)
export TYPE := ace
datafiles := $(patsubst YAML/%.yaml,Data/%.rvdata2,$(wildcard YAML/*.yaml))
yamlfiles := $(patsubst Data/%.rvdata2,YAML/%.yaml,$(wildcard Data/*.rvdata2))

unpack: $(yamlfiles)

pack: $(datafiles)

clean-yaml:
	rm -f YAML/*

clean-data:
	rm -f Data/*

$(datafiles): Data/%.rvdata2: YAML/%.yaml
	rvpacker --verbose -d $(PROJECT) -t $(TYPE) -a pack -D $*

$(yamlfiles): YAML/%.yaml : Data/%.rvdata2
	rvpacker --verbose --force -d $(PROJECT) -t $(TYPE) -a unpack -D $*
