# Importr

Rails Engine to wich extend active-admin to import excel files, based on top of active-importer dsl import.

## Installation

Add this line to your application's Gemfile:

    gem 'importr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install importr

## Dependences

    [SideKiq](https://github.com/mperham/sidekiq)Sidekiq
    [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)carrierwave


## Usage

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


### WebSocket integration

If you need to emit the progress of importation in realtime, like errors validations, you can configure the Importer in an initializer for websocket notification:

    Importr::Config.setup do |config|
      config.web_socket_class  = 'Faye' 
      config.web_socket_method = "publish"
    end

Importr will manage the event publication for errors 
