# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :categoria
  belongs_to :status

  has_one_attached :imagem
  has_rich_text :corpo

  validates :titulo, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :corpo, presence: true
  validate :imagem_ate_10mb

  IMAGEM_TAMANHO_MAXIMO = 10.megabytes

  scope :publicados, -> { joins(:status).where(statuses: { nome: "publicado" }) }
  scope :por_data, -> { order(publicado_em: :desc, created_at: :desc) }
  scope :rascunhos, -> { joins(:status).where(statuses: { nome: "rascunho" }) }

  before_validation :gerar_slug, if: -> { slug.blank? && titulo.present? }
  before_save :calcular_tempo_leitura

  def publicado? = status&.publicado?
  def rascunho?  = status&.rascunho?

  private

  def imagem_ate_10mb
    return unless imagem.attached?

    if imagem.blob.byte_size > IMAGEM_TAMANHO_MAXIMO
      errors.add(:imagem, "deve ter até 10MB")
    end
  end

  def gerar_slug
    self.slug = titulo.to_s
      .unicode_normalize(:nfd).gsub(/\p{Mn}/, "")
      .downcase
      .gsub(/[^a-z0-9]+/, "-")
      .gsub(/^-|-$/, "")
  end

  def calcular_tempo_leitura
    return if corpo.blank?

    palavras = corpo.to_plain_text.split.size
    self.tempo_leitura_min = [ (palavras / 200.0).ceil, 1 ].max
  end
end
