# This migration comes from postablr (originally 20121222200303)
# -*- encoding : utf-8 -*-
class CreatePostablrEntryLinks < ActiveRecord::Migration
  def change
    create_table :postablr_entry_links do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
