# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include LayoutByUser
  include Pagy::Backend

  allow_browser versions: :modern

  before_action :set_locale

  private

  def set_locale
    I18n.locale = :"pt-BR"
  end

  def after_sign_in_path_for(_resource)
    admin_root_path
  end

  def after_sign_out_path_for(_resource)
    new_usuario_session_path
  end
end
