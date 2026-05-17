# frozen_string_literal: true

module Admin
  class SessionsController < Devise::SessionsController
    layout "devise"

    private

    def definir_layout
      # noop — layout fixado acima
    end
  end
end
