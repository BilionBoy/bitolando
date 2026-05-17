# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :categoria
  belongs_to :status

  has_one_attached :imagem

  validates :titulo, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :corpo, presence: true

  scope :publicados, -> { joins(:status).where(statuses: { nome: "publicado" }) }
  scope :por_data, -> { order(publicado_em: :desc, created_at: :desc) }
  scope :rascunhos, -> { joins(:status).where(statuses: { nome: "rascunho" }) }

  before_validation :gerar_slug, if: -> { slug.blank? && titulo.present? }
  before_save :calcular_tempo_leitura, if: -> { corpo_changed? }

  def publicado? = status&.publicado?
  def rascunho?  = status&.rascunho?

  private

  def gerar_slug
    self.slug = titulo.to_s
      .unicode_normalize(:nfd).gsub(/\p{Mn}/, "")
      .downcase
      .gsub(/[^a-z0-9]+/, "-")
      .gsub(/^-|-$/, "")
  end

  def calcular_tempo_leitura
    return if corpo.blank?

    palavras = corpo.split.size
    self.tempo_leitura_min = [ (palavras / 200.0).ceil, 1 ].max
  end
end
