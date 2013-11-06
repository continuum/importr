# require 'active_importer'

module Importr
  class Importer < ActiveImporter::Base
    def initialize(file, options = {})
      # TODO: ensure that data_import.model_class == self.class.model_class

      super

      if data_import && data_import.finished
        raise "Data import #{data_import.id} was already processed"
      end
    end

    alias_method :data_import, :context

    def row_success
      super
      update_counters
      notify(:success, @counters)
    end

    def row_error(error_message)
      super
      update_counters
      notify(:error, @counters.merge(index: row_index, error: error_message))
    end

    def import_failed(error_message)
      super
      notify(:base, error: error_message)
    end

    def import_finished
      data_import.update_attribute(:finished, true) if data_import
    end

    private

    def notify(subchannel, message)
      channel = ["/#{self.class}/#{subchannel}", data_import.try(:uuid)].compact.join("-")
      Importr::Notifier.notify(channel, message)
    end

    def update_counters
      @counters = {
        success_count: row_success_count,
        error_count: row_error_count,
        processed_rows: row_processed_count,
        total_rows: row_count,
      }
      data_import.update_attributes(@counters) if data_import
    end
  end
end
