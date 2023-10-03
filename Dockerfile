FROM ruby:3.0.0-alpine

RUN apk update

RUN apk add --update --virtual \
postgresql-client \
build-base \

readline \
build-base \
postgresql-dev \
libc-dev \
linux-headers \
readline-dev \
file \
imagemagick \
git \
tzdata \
nodejs \
yarn \
&& rm -rf var/cache/apk*


WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install

ENTRYPOINT [ "bin/rails" ]
# Expose the port that your Rails app will run on (usually 3000)


# Start the Rails server
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000