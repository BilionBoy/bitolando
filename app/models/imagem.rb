# frozen_string_literal: true

class Imagem < ApplicationRecord
  self.table_name = "imagens"

  has_one_attached :arquivo

  validates :arquivo, presence: true

  scope :recentes, -> { order(created_at: :desc) }
end
