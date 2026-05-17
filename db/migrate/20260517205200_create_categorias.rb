# frozen_string_literal: true

class CreateCategorias < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:categorias)
      create_table :categorias do |t|
        t.string  :nome,     null: false
        t.string  :slug,     null: false
        t.text    :descricao
        t.integer :posicao,  null: false, default: 0
        t.timestamps
      end
    end

    add_index :categorias, :slug, unique: true unless index_exists?(:categorias, :slug)
    add_index :categorias, :nome, unique: true unless index_exists?(:categorias, :nome)
  end
end
