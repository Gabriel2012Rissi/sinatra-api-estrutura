FROM ruby:3.2.0-alpine

# Set environment variables
ENV PORT 3000
ENV SINATRA_DIR /app
ENV SINATRA_ENV production

# Update and install dependencies
RUN apk update \
    && apk upgrade \
    && apk add --no-cache alpine-sdk \
                          bash \
                          postgresql-dev

# Create and set the working directory
RUN mkdir -p ${SINATRA_DIR}
WORKDIR ${SINATRA_DIR}

# Copy the Gemfile and install gems
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE ${PORT}

# Execute app
CMD ["bundle", "exec", "foreman", "start"]