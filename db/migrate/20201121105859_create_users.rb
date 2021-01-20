# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :token
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_index :users, :email, unique: true
    add_index :users, :token, unique: true
  end

  def down
    remove_index :users, :email
    drop_table :users
  end
end
