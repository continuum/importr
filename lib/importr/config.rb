require "active_support/core_ext/module/attribute_accessors"

module Importr
  class Config

    def self.setup
      yield self
    end

    mattr_accessor  :web_socket_class, :web_socket_method, 
                    :websocket_url_service, :websocket_client_script, 
                    :restriction_method


  end
end