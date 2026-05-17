# frozen_string_literal: true

class Status < ApplicationRecord
  has_many :posts, dependent: :restrict_with_error

  validates :nome, presence: true, uniqueness: true

  scope :ordenados, -> { order(:posicao, :nome) }

  def rascunho?   = nome == "rascunho"
  def publicado?  = nome == "publicado"
  def agendado?   = nome == "agendado"
end
