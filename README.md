# Importr

Extends active-admin to import excel files. Based on [Active-Importer](https://github.com/continuum/active_importer) dsl import.

[![Build Status](https://secure.travis-ci.org/continuum/importr.png)](http://travis-ci.org/continuum/importr) [![Coverage Status](https://coveralls.io/repos/continuum/importr/badge.png)](https://coveralls.io/r/continuum/importr)
=======

## Installation

Add this line to your application's Gemfile:

    gem 'importr'

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

Go to [Active-Importer](https://github.com/continuum/active_importer) documentation for more information about importers

### Active Admin support

    ActiveAdmin.register Pricing do
      menu parent: "Money"
      data_import_interface
    end


### Access restriction

To restrict access to the import data actions you need to supply restriction_method in importr config, example:

#### config/importr.rb

    Importr::Config.setup do |config|
      config.restriction_method       = "check_importr_roles"
    end 

#### appplication_controller.rb

    def check_importr_roles
      raise CanCan::AccessDenied unless current_admin_user.is_admin?
    end

## WebSocket integration, Faye example


There are two ways to notify progress, errors and validation messages of an import; by default Importr uses Ajax Poll strategy. If you need to notify the progress more smoothly, you can configure websocket notification in an initializer:

    Importr::Config.setup do |config|
      config.web_socket_class         = 'FayeWrapper'
      config.web_socket_method        = "publish"
      config.websocket_url_service    = "http://localhost:8000/faye"
      config.websocket_client_script  = "http://localhost:8000/faye/client.js"
    end

Importr will manage the event publication for errors and send notifications with web_socket_class.publish method.

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

Finnaly you must to run a Faye websocket server

## Dependencies

[SideKiq](https://github.com/mperham/sidekiq)

[CarrierWave](https://github.com/carrierwaveuploader/carrierwave)

## Maintainers
* Miguel Michelson [github/michelson](https://github.com/michelson)
* Ernesto García [github/gnapse](https://github.com/gnapse)

Copyright (c) 2013 continuum, released under the MIT license
