
build-base: .out/base

.out/base: base.Dockerfile student.sudoers task
	docker build -t practice-base -f base.Dockerfile --build-arg basedir=. .
	touch .out/base
