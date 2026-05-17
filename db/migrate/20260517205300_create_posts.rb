# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    unless table_exists?(:posts)
      create_table :posts do |t|
        t.string   :titulo,           null: false
        t.string   :slug,             null: false
        t.text     :corpo
        t.integer  :tempo_leitura_min, null: false, default: 0
        t.datetime :publicado_em

        t.references :categoria, null: false, foreign_key: { to_table: :categorias }
        t.references :status,    null: false, foreign_key: { to_table: :statuses }

        t.timestamps
      end
    end

    add_index :posts, :slug,         unique: true unless index_exists?(:posts, :slug)
    add_index :posts, :publicado_em              unless index_exists?(:posts, :publicado_em)
  end
end
