# frozen_string_literal: true

class Imagem < ApplicationRecord
  has_one_attached :arquivo

  validates :arquivo, presence: true

  scope :recentes, -> { order(created_at: :desc) }
end
