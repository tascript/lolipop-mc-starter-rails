# frozen_string_literal: true

class CreateAuthentications < ActiveRecord::Migration[6.0]
  def up
    create_table :authentications, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :token, null: false
      t.integer :reload_count, null: false, default: 0
      t.string :user_id, limit: 36, null: false
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_foreign_key :authentications, :users
    add_index :authentications, :token, unique: true
  end

  def down
    remove_foreign_key :authentications, :users
    drop_table :authentications
  end
end
