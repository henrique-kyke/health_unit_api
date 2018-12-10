FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs tzdata
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /health_unit_api
WORKDIR /health_unit_api
RUN gem install bundler
COPY Gemfile /health_unit_api/Gemfile
COPY Gemfile.lock /health_unit_api/Gemfile.lock
RUN gem install bundler
RUN bundle install --without development test
COPY . /health_unit_api
RUN mkdir -p /health_unit_api/tmp/pids
CMD ["bundle", "exec", "unicorn", "-c", "/health_unit_api/config/unicorn.rb", "-E", "production"]
