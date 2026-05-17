# frozen_string_literal: true

class AddVideoUrlToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :video_url, :string unless column_exists?(:posts, :video_url)
  end
end
