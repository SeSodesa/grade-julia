# grade-julia

A Docker image for grading exercises written in the [Julia programming
language][Julia] on the [A+ learning management system][A+], developed at Aalto
University. To build the container image, you must [install Docker], navigate
to this folder and run the `docker build` command ([link][docker-build])

	docker build --tag organization/grade-julia:tag .

in the terminal emulator of your choice.

[Julia]: https://julialang.org/
[A+]: https://apluslms.github.io/
[install Docker]: https://docs.docker.com/get-docker/
[docker-build]: https://docs.docker.com/engine/reference/commandline/build/
