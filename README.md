# Importr

Extends active-admin to import excel files. Based on [Active-Importer](https://github.com/continuum/active_importer) dsl import.

[![Build Status](https://secure.travis-ci.org/continuum/importr.png)](http://travis-ci.org/continuum/importr) [![Coverage Status](https://coveralls.io/repos/continuum/importr/badge.png)](https://coveralls.io/r/continuum/importr)
=======

## Installation

Add this line to your application's Gemfile:

    gem 'importr'

Then execute:

    $ bundle

Or just install it as gem if you don't use bundler:

    $ gem install importr

## Usage

Install migrations:

    $ rake importr:install:migrations

Add your importers in app/importers. Here is a importer example:

    class PricingImporter < Importr::Importer
      imports Pricing

      column 'Fecha', :date
      column 'Precio/tasa', :value
      column 'Vector precio', :vector_id
    end

Go to active-importer documentation for more information about importers

### Active Admin support

    ActiveAdmin.register Pricing do
      menu parent: "Money"
      data_import_interface
    end


### WebSocket integration, Faye example

If you need to notify the progress of a import in real time (and
errors or validation issues), you can configure websocket notification
in an initializer:


    Importr::Config.setup do |config|
      config.web_socket_class         = 'FayeWrapper'
      config.web_socket_method        = "publish"
      config.websocket_url_service    = "http://localhost:8000/faye"
      config.websocket_client_script  = "http://localhost:8000/faye/client.js"
    end

Importr will manage the event publication for errors and send notifications with FayeWrapper.publish.

### Faye Wrapper example

In config/initializers/faye.rb write something like

    WS_CLIENT = Faye::Client.new('http://localhost:8000/faye')

    class FayeWrapper
      def self.publish(channel, message)
        run_event_machine
        puts "#{channel} #{message}"
        WS_CLIENT.publish(channel, message)
      end

      def self.run_event_machine
        Thread.new { EM.run } unless EM.reactor_running?
        Thread.pass until EM.reactor_running?
      end
    end

Finnaly you must to run a Faye server

## Dependencies

[SideKiq](https://github.com/mperham/sidekiq)

[CarrierWave](https://github.com/carrierwaveuploader/carrierwave)
