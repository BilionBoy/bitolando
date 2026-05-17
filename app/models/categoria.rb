# frozen_string_literal: true

class Categoria < ApplicationRecord
  has_many :posts, dependent: :restrict_with_error

  validates :nome, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  scope :ordenadas, -> { order(:posicao, :nome) }

  before_validation :gerar_slug, if: -> { slug.blank? && nome.present? }

  private

  def gerar_slug
    self.slug = nome.to_s
      .unicode_normalize(:nfd).gsub(/\p{Mn}/, "")
      .downcase
      .gsub(/[^a-z0-9]+/, "-")
      .gsub(/^-|-$/, "")
  end
end
