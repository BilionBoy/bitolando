# frozen_string_literal: true

class RemoveCorpoFromPosts < ActiveRecord::Migration[7.2]
  def change
    # Sem posts publicados ainda (blog novo) — corpo vira ActionText::RichText
    # (has_rich_text :corpo no model), sem necessidade de migrar dado.
    remove_column :posts, :corpo, :text if column_exists?(:posts, :corpo)
  end
end
