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

    on :row_success do
      update_counters
      notify(:success, @counters)
    end

    on :row_error do |e|
      update_counters({index: row_index, error: e.message})
      notify(:error, @counters.merge(index: row_index, error: e.message))
    end

    on :import_failed do |e|
      notify(:base, error: e.message)
    end

    on :import_finished do
      data_import.update_attribute(:finished, true) if data_import
    end

    private

    def notify(subchannel, message)
      channel = ["/#{self.class}/#{subchannel}", data_import.try(:uuid)].compact.join("-")
      Importr::Notifier.notify(channel, message)
    end

    def update_counters(err= {})
      @counters = {
        success_count: row_success_count,
        error_count: row_error_count,
        processed_rows: row_processed_count,
        total_rows: row_count,
      }
      if data_import
        data_import.update_attributes(@counters) 
        add_error(err) unless err.blank?
      end
    end

    def add_error(err)
      data_import.update_attributes(error_messages: data_import.error_messages << err ) if data_import
    end
  end
end
