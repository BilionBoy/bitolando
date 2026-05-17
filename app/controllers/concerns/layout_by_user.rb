# frozen_string_literal: true

module LayoutByUser
  extend ActiveSupport::Concern

  included do
    before_action :definir_layout
  end

  private

  def definir_layout
    if devise_controller?
      self.class.layout "devise"
    elsif self.class.name.to_s.start_with?("Admin::")
      self.class.layout "admin"
    else
      self.class.layout "application"
    end
  end
end
