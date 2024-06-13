

.PHONY:  docker-gen docker-build all




local-gen: 
	nu gen.nu gen $(mpath) $(mname)
docker-build:
	docker rmi ddd/gen:v0.1 -f
	docker build -t ddd/gen:v0.1 --no-cache . 
gen:
	docker run --rm -v ${PWD}:/gen ddd/gen:v0.1  nu gen.nu gen $(mpath) $(mname)
all: docker-build gen 