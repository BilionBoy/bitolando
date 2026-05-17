# frozen_string_literal: true

class DeviseCreateUsuarios < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:usuarios)
      create_table :usuarios do |t|
        t.string :email,              null: false, default: ""
        t.string :encrypted_password, null: false, default: ""
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
        t.datetime :remember_created_at
        t.timestamps null: false
      end
    end

    add_index :usuarios, :email,                unique: true unless index_exists?(:usuarios, :email)
    add_index :usuarios, :reset_password_token, unique: true unless index_exists?(:usuarios, :reset_password_token)
  end
end
