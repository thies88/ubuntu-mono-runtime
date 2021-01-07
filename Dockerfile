# Set global vars
ARG REL=focal

FROM thies88/base-ubuntu:${REL}

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thies88"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
echo "**** install apt-transport-https ****" && \
 apt-get update && \
 apt-get install -y apt-transport-https gnupg2 && \
 echo "**** add mono repository ****" && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
 echo "deb http://download.mono-project.com/repo/ubuntu ${REL} main" | tee /etc/apt/sources.list.d/mono-official.list && \
 echo "**** add mediaarea repository ****" && \
 curl -L \
	"https://mediaarea.net/repo/deb/repo-mediaarea_1.0-14_all.deb" \
	-o /tmp/key.deb && \
 dpkg -i /tmp/key.deb && \
 echo "deb https://mediaarea.net/repo/deb/ubuntu ${REL} main" | tee /etc/apt/sources.list.d/mediaarea.list && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install --no-install-recommends -y \
	mono-runtime-common \
	mono-vbnc \
	jq \
	libicu?? \
	libmediainfo??? \
	sqlite3 && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*
