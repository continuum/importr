module Importr
  module ApplicationHelper
    
    def websocket_url_service
      Importr::Config.websocket_url_service
    end

    def websocket_client_script
      Importr::Config.websocket_client_script
    end

  end
end
