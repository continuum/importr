module Importr
  module ApplicationHelper
    
    def websocket_url_service
      Importr::Config.websocket_url_service
    end

    def websocket_client_script
      Importr::Config.websocket_client_script
    end

    def websocket_configured?
      Importr::Config.websocket_url_service.present? && Importr::Config.websocket_client_script.present?
    end

    def calculate_progress(data_import)
      (data_import.processed_rows.to_f/data_import.total_rows.to_f)*100/100
    end

  end
end
