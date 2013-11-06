# Importr

Rails Engine to wich extend active-admin to import excel files, based on top of [Active-Importer](https://github.com/continuum/active_importer) dsl import.

[![Build Status](https://secure.travis-ci.org/continuum/importr.png)](http://travis-ci.org/continuum/importr) [![Dependency Status](https://gemnasium.com/continuum/importr.png)](https://gemnasium.com/continuum/espinita) [![Coverage Status](https://coveralls.io/repos/continuum/importr/badge.png?branch=master)](https://coveralls.io/r/continuum/importr?branch=master)
=======

## Installation

Add this line to your application's Gemfile:

    gem 'importr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install importr

## Dependences

[SideKiq](https://github.com/mperham/sidekiq)

[CarrierWave](https://github.com/carrierwaveuploader/carrierwave)


## Usage

Install migrations

    $ rake importr:install:migrations

Add an your importers in app/importers

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

If you need to emit the progress of importation in realtime, like errors validations, you can configure the Importer in an initializer for websocket notification:


    Importr::Config.setup do |config|
      config.web_socket_class         = 'FayeWrapper'
      config.web_socket_method        = "publish"
      config.websocket_url_service    = "http://localhost:8000/faye"
      config.websocket_client_script  = "http://localhost:8000/faye/client.js"
    end

Importr will manage the event publication for errors send notifications with FayeWrapper.publish

### Faye Wrapper example

in config/initializers/faye.rb write something like

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

finnaly you must to run a Faye server


