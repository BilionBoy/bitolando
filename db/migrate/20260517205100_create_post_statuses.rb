# frozen_string_literal: true

class CreatePostStatuses < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:statuses)
      create_table :statuses do |t|
        t.string  :nome,    null: false
        t.integer :posicao, null: false, default: 0
        t.timestamps
      end
    end

    add_index :statuses, :nome, unique: true unless index_exists?(:statuses, :nome)
  end
end
