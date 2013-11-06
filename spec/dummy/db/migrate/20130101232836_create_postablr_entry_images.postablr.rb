# This migration comes from postablr (originally 20121222200402)
# -*- encoding : utf-8 -*-
class CreatePostablrEntryImages < ActiveRecord::Migration
  def change
    create_table :postablr_entry_images do |t|
      t.string :photo
      t.text :body
      t.string :photo_content_type
      t.string :photo_size

      t.timestamps
    end
  end
end
