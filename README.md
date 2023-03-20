# grade-julia

A Docker image for grading exercises written in the [Julia programming
language][Julia] on the [A+ learning management system][A+], developed at Aalto
University. To build the container image, you must [install Docker], navigate
to this folder and run the `docker build` command ([docs][docker-build])

	docker build --tag organization/grade-julia:tag .

in the terminal emulator of your choice. Also see the [Docker Hub page][Docker Hub] for this
repository.

[Julia]: https://julialang.org/
[A+]: https://apluslms.github.io/
[install Docker]: https://docs.docker.com/get-docker/
[docker-build]: https://docs.docker.com/engine/reference/commandline/build/
[Docker Hub]: https://hub.docker.com/repository/docker/sesodesa/grade-julia
