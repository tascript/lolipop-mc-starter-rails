# frozen_string_literal: true

class CreateBlogs < ActiveRecord::Migration[6.0]
  def up
    create_table :blogs, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :title, limit: 100, null: false
      t.text :document, limit: 500, null: false
      t.string :user_id, limit: 36, null: false
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_foreign_key :blogs, :users
  end

  def down
    remove_foreign_key :blogs, :users
    drop_table :blogs
  end
end
