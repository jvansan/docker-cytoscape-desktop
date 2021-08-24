NAME := cytoscape-desktop-headless
# VERSION := $(shell git describe --tags)
VERSION := latest
REGISTRY := jvansan

all: build-docker tag push

build-docker:
	docker build -t $(NAME):$(VERSION) -t $(NAME):latest .

tag:
	docker tag $(NAME):$(VERSION) $(REGISTRY)/$(NAME):$(VERSION)

push:
	docker push $(REGISTRY)/$(NAME):$(VERSION)

echo-name:
	echo $(REGISTRY)/$(NAME):$(VERSION)