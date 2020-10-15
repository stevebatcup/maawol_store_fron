FROM ruby:2.6.6

RUN apt-get update -yqq \
		&& apt-get install -yqq --no-install-recommends \
		postgresql-client vim nodejs \
		&& rm -rf /var/lib/apt/lists

ENV BUNDLE_PATH /gems
ENV APP_NAME store_front
ENV APP_PATH /usr/src/app
ENV PATH $APP_PATH/bin:$PATH

WORKDIR $APP_PATH

ADD . $APP_PATH

ENV RAILS_ENV development

EXPOSE 4010
CMD ./lib/docker-entrypoint.sh
