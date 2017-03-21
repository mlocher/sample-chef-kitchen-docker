FROM ruby:2.4
LABEL maintainer "Marko Locher <marko@codeship.com>"

ENV \
	DEBIAN_DISTRIBUTION="jessie"

RUN \
	DEBIAN_FRONTEND="noninteractive" \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		curl && \
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
	echo "deb https://download.docker.com/linux/debian ${DEBIAN_DISTRIBUTION} stable" > /etc/apt/sources.list.d/docker.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		docker-ce

RUN mkdir -p /kitchen
WORKDIR /kitchen

COPY Gemfile Gemfile.lock ./

RUN \
	echo "gem: --no-rdoc --no-ri" >> ${HOME}/.gemrc && \
	bundle install --jobs 20 --retry 5 --without development

COPY . ./

ENTRYPOINT ["kitchen"]
