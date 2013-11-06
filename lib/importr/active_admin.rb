module Importr
  module ActiveAdmin

    def data_import_interface(importer_type = nil)
      klass = config.resource_class.name
      importer_type ||= "#{klass}Importer".constantize

      action_item :only => :index do
        link_to 'Import from Excel', :action => 'upload_excel'
      end

      collection_action :upload_excel do
        @data_import = DataImport.new(importer_type: importer_type)
        @data_import.generate_uuid
        render "importr/admin/data_imports/form"
      end

      collection_action :import_excel, :method => :post do
        @data_import = DataImport.new(permitted_params[:data_import])
        @data_import.resource_type = klass
        @data_import.user_id = current_admin_user.id
        @data_import.importer_type = importer_type.to_s.to_sym
        @data_import.save
        redirect_to [:admin, @data_import]
      end

      controller do
        def permitted_params
          params.permit data_import: [:document, :uuid, :importer_type]
        end
      end
    end

  end
end
