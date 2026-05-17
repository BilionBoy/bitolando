# frozen_string_literal: true

module MarkdownHelper
  RENDERER = Redcarpet::Render::HTML.new(
    hard_wrap: true,
    link_attributes: { target: "_blank", rel: "noopener" },
    prettify: false
  )

  MARKDOWN = Redcarpet::Markdown.new(
    RENDERER,
    autolink: true,
    tables: true,
    fenced_code_blocks: true,
    strikethrough: true,
    superscript: true,
    underline: false,
    highlight: false,
    quote: false,
    footnotes: false
  )

  def render_markdown(text)
    return "" if text.blank?

    MARKDOWN.render(text.to_s).html_safe
  end

  def youtube_embed_id(url)
    return nil if url.blank?

    url.to_s.match(/(?:v=|youtu\.be\/|embed\/)([A-Za-z0-9_\-]{11})/)&.captures&.first
  end
end
