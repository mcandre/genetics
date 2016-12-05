all: lint

hlint:
	hlint .

editorconfig:
	sh editorconfig.sh

lint: hlint editorconfig
