FactoryGirl.define do
  factory :importr_data_import, :class => 'Importr::DataImport' do
    document File.open(File.join(Rails.root, '/spec/fixtures/doc.xlsx'))
    user nil
    #importer_type "MyString"
    #resource_type "MyString"
    #document_processing false
    #data "MyText"
    #uuid "MyString"
  end
end