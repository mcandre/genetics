all: lint

hlint:
	hlint .

editorconfig:
	flcl . | xargs -n 100 editorconfig-cli check

lint: hlint editorconfig
