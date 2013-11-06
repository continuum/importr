# This migration comes from postablr (originally 20121222200237)
# -*- encoding : utf-8 -*-
class CreatePostablrEntryPosts < ActiveRecord::Migration
  def change
    create_table :postablr_entry_posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
