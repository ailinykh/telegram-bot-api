.PHONY: push docker

TAG:=ailinykh/telegram-bot-api

all: docker push

push:
	docker push $(TAG)

docker:
	docker build -t $(TAG) .