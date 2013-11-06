module Importr
  class DataImport < ActiveRecord::Base
    belongs_to :user
    mount_uploader :document, Importr::Uploader
    serialize :error_messages, Array

    def websocket_channel(scope)
      #return "/#{resource.resource_type}/#{self.importer_type}/#{scope}"
      return "/#{self.importer_type}/#{scope}-#{self.uuid}"
    end

    def generate_uuid
      self.uuid = Digest::SHA1.hexdigest(Time.now.to_i.to_s)
    end

    def progress_text
      total_rows.blank? ? "None" : "#{processed_rows || 0} / #{total_rows}"
    end

    def error_count_text
      error_count.blank? ? "None" : error_count
    end

    def status_text
      if finished
        total_rows.blank? ? "Failed" : "Finished"
      else
        "In progress"
      end
    end

    def importer_class
      self.importer_type.constantize
    end

    def file_path
      self.document.file.file
    end

    def perform
      importer_class.import(file_path, context: self)
    end
  end
end
