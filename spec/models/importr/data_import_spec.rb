require 'spec_helper'

module Importr
  describe DataImport do
    
    let(:importer_type){ "SomeImporter".constantize }
    
    let(:data_import){ 
      DataImport.new(importer_type: importer_type)
    }

    let(:build_data_import){
      FactoryGirl.build(:importr_data_import)
    }

    it "should generate uuid" do
      expect( data_import.generate_uuid ).not_to be_blank
    end

    it "importer type shuld be SomeImporter class ?" do
      expect(data_import.importer_type).to eql SomeImporter
    end

    describe "build data import with file" do

      let(:model){
        build_data_import.document = File.open(File.join(Rails.root, '/spec/fixtures/doc.xlsx'))
        build_data_import.importer_type = "SomeImporter"
        build_data_import.resource_type = "GeneralModel"
        build_data_import
      }

      it "should have file" do
        model.save
        expect(model.document.url).not_to be_blank
      end

      it "should have many associated models" do
        expect( lambda{ model.save } ).to change{GeneralModel.count}
      end
    end



  end
end
