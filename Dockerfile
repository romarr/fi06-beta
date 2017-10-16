FROM ruby as build-env
RUN apt-get update && apt-get install -y build-essential ruby-dev nodejs
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . ./
RUN JEKYLL_ENV=production bundle exec jekyll build --verbose

FROM nginx:alpine
COPY --from=build-env _site _site
COPY nginx.conf /etc/nginx/conf.d/default.conf