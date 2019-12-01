DOCKER_REPO ?= maxbischoff
TAG ?= latest
task_folders = $(patsubst %/task,%,$(wildcard */*/task))

.PHONY: build-tasks build-base readmes push-tasks push-base

build-base: .out/base
push-base: .out/base_pushed
build-tasks: .out/$(task_folders)
push-tasks: .out/$(task_folders)/pushed
readmes: $(task_folders)/README.md

.out/base: base.Dockerfile student.sudoers .base/*
	docker build -t practice-base -f base.Dockerfile --build-arg basedir=.base/ .
	touch .out/base

.out/base_pushed: .out/base
	docker tag practice-base $(DOCKER_REPO)/practice-base
	docker push $(DOCKER_REPO)/practice-base:$(TAG)
	touch .out/base_pushed

.out/$(task_folders): $(task_folders)/*
	docker build -t $(subst /,_,$(task_folders)) -f base.Dockerfile --build-arg basedir=$(task_folders) .
	mkdir -p $@

.out/$(task_folders)/pushed: .out/$(task_folders)
	docker tag $(subst /,_,$(task_folders)) $(DOCKER_REPO)/$(subst /,_,$(task_folders))
	docker push $(DOCKER_REPO)/$(subst /,_,$(task_folders)):$(TAG)
	touch $@

$(task_folders)/README.md: $(task_folders)/task tasks-readme-base.md
	cp tasks-readme-base.md $@
	sed -i "" -e 's/HEADING/$(subst /,: ,$(task_folders))/g' $@
	sed -i "" -e 's#IMAGE#$(DOCKER_REPO)/$(subst /,_,$(task_folders))#g' $@
	cat $(dir $@)/task >> $@

.PHONY: clean clean-readmes
clean: clean-readmes
	rm -rf .out/*

clean-readmes:
	rm -f $(task_folders)/README.md
