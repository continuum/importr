module Importr
  class Worker
    include Sidekiq::Worker

    def perform(data_import_id)
      data_import = Importr::DataImport.find(data_import_id)
      data_import.perform
    end
  end
end
