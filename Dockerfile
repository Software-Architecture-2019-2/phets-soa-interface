FROM ruby:2

RUN mkdir /phets_soa_interface
WORKDIR /phets_soa_interface

ADD Gemfile /phets_soa_interface/Gemfile
ADD Gemfile.lock /phets_soa_interface/Gemfile.lock

RUN bundle install
ADD . /phets_soa_interface

EXPOSE 2000