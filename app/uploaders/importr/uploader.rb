
module Importr
  class Uploader < CarrierWave::Uploader::Base
    storage :file
    after :store, :importer

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{model.id}"
    end

    def importer(new_file)
      #Importr::Worker.perform_in(5.seconds, model.id)
      Importr::Worker.perform_async(model.id)
    end
  end
end
