xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc root_url
    xml.changefreq "daily"
    xml.priority "1.0"
  end

  xml.url do
    xml.loc sobre_url
    xml.changefreq "weekly"
    xml.priority "0.9"
  end

  @categorias.each do |categoria|
    xml.url do
      xml.loc categoria_url(categoria.slug)
      xml.lastmod categoria.updated_at&.iso8601
      xml.changefreq "weekly"
      xml.priority "0.7"
    end
  end

  @posts.each do |post|
    xml.url do
      xml.loc post_url(post.slug)
      xml.lastmod (post.updated_at || post.publicado_em || post.created_at)&.iso8601
      xml.changefreq "weekly"
      xml.priority "0.8"
    end
  end
end
