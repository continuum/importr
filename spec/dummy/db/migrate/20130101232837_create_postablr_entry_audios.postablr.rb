# This migration comes from postablr (originally 20121222200810)
# -*- encoding : utf-8 -*-
class CreatePostablrEntryAudios < ActiveRecord::Migration
  def change
    create_table :postablr_entry_audios do |t|
      t.string :file
      t.string :file_size
      t.string :file_content_type
      t.text :body
      t.string :title
      t.timestamps
    end
  end
end
