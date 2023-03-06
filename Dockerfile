### Dockerfile
#
# This file instructs Docker how to build the grading container. If everything
# goes as intended, it
#
# 1. downloads Julia from the official website with cURL,
# 2. downloads the checksum file from the same website with cURL,
# 3. checks the downloaded Julia archive against the checksum with sha256sum,
# 4. unpacks the downloaded Julia archive to /usr/local/
# 5. symbolically links the contained binary to /usr/local/bin and
# 6. removes the downloaded files to reduce final image size.
#

## A+ grader-related variables and inheriting from grading-base.

ARG BASE_TAG=latest

FROM apluslms/grading-base:$BASE_TAG

ARG GRADER_UTILS_VER=4.8

## Julia-related variable names.

ARG JULIA_BRANCH=1.8

ARG JULIA_VERSION=${JULIA_BRANCH}.5

ARG JULIA_ARCHIVE=julia-${JULIA_VERSION}-linux-x86_64.tar.gz

ARG JULIA_DOWNLOAD_URL=https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_BRANCH}/${JULIA_ARCHIVE}

ARG JULIA_CHECKSUMS=julia-${JULIA_VERSION}.sha256

ARG JULIA_CHECKSUM_URL=https://julialang-s3.julialang.org/bin/checksums/${JULIA_CHECKSUMS}

ARG JULIA_CHECKSUM=julia.sha256

## Building the image.

RUN \
	curl -o "$JULIA_ARCHIVE" "$JULIA_DOWNLOAD_URL" \
	&& \
	curl -o "$JULIA_CHECKSUMS" "$JULIA_CHECKSUM_URL" \
	&& \
	grep "${JULIA_ARCHIVE}" "$JULIA_CHECKSUMS" > "$JULIA_CHECKSUM" \
	&& \
	sha256sum --check "$JULIA_CHECKSUM" \
	&& \
	tar -xvf "${JULIA_ARCHIVE}" --directory /usr/local/ \
	&& \
	ln -s "/usr/local/julia-${JULIA_VERSION}/bin/julia" /usr/local/bin/julia \
	&& \
	rm "${JULIA_ARCHIVE}" "${JULIA_CHECKSUMS}" "${JULIA_CHECKSUM}"

## TODO
#
# Add a grading script that is run when the container is started.
