# frozen_string_literal: true

class Usuario < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  validates :email, presence: true
end
