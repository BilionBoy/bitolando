# frozen_string_literal: true

class CreateImagens < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:imagens)
      create_table :imagens do |t|
        t.string :legenda
        t.timestamps
      end
    end
  end
end
