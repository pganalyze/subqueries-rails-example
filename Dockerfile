FROM ruby:2.7
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN echo "deb https://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client-12
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]