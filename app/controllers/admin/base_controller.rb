# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    layout "admin"
    before_action :authenticate_usuario!

    private

    def definir_layout
      # já fixado no layout "admin" acima — sobrescreve o concern
    end
  end
end
