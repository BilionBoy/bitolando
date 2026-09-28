# frozen_string_literal: true

module VideoHelper
  def youtube_embed_id(url)
    return nil if url.blank?

    url.to_s.match(/(?:v=|youtu\.be\/|embed\/)([A-Za-z0-9_\-]{11})/)&.captures&.first
  end
end
