require 'spec_helper'
require 'date'
require 'stubs/some_websocket_wrapper'

describe Importr::Importer do

  before :each do
    Importr::Importer.any_instance.stub(:data).and_return(:return_value)
    Importr::Config.setup do |config|
      config.web_socket_class = 'SomeWebsocketWrapper'
      config.web_socket_method = 'publish'
    end
  end

  let(:schema) do
    Importr::ImportSchema.new(MoneyExchange, :admin) do |schema|
      schema.column 'Cambio', :change do |value|
        value.reverse
      end
      schema.column 'Valor 1', :value1, ->(value) { value.to_i*2 }
      schema.column 'Valor 2', :value2, ->(value) { value.to_i*2 }
      schema.column 'Fecha', :date
    end
  end

  let(:importer) { Importr::Importer.new(schema: schema, file_name: 'file_name.xls', uuid: '1234') }
  let(:header) { ['Cambio', 'Valor 1', 'Valor 2', 'Fecha'] }
  let(:row) { ['USDCLP', '500', '400', '2013/10/15'] }

end
