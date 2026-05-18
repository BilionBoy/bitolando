module ApplicationHelper
  include Pagy::Frontend

  def seo_site_name
    "bitolando"
  end

  def seo_base_url
    "https://bitolando.online"
  end

  def seo_title
    content_for(:title).presence || seo_site_name
  end

  def seo_description
    content_for(:description).presence || "bitolando: engenharia de software, arquitetura, decisões técnicas e execução real."
  end

  def seo_canonical_url
    content_for(:canonical_url).presence || request.original_url
  end

  def seo_og_image
    content_for(:og_image).presence || "#{seo_base_url}/layout/assets/img/bitolando-symbol-dark.png"
  end

  def seo_json_ld
    content_for(:structured_data).presence
  end
end
