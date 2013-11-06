class CreateImportrDataImports < ActiveRecord::Migration
  def change
    create_table :importr_data_imports do |t|
      t.string :importer_type
      t.string :resource_type
      t.string :document
      t.boolean :finished, default: false
      t.references :user, index: true
      t.text :error_messages
      t.integer :success_count
      t.integer :error_count
      t.integer :processed_rows
      t.integer :total_rows
      t.string :uuid

      t.timestamps
    end
  end
end
