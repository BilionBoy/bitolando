xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "bitolando"
    xml.description "caderno público de engenharia e arquitetura de software"
    xml.link root_url
    xml.language "pt-BR"
    xml.tag!("atom:link", href: rss_feed_url(format: :xml), rel: "self", type: "application/rss+xml")

    @posts.each do |post|
      xml.item do
        xml.title post.titulo
        xml.description post.corpo.to_s.truncate(500)
        xml.pubDate post.publicado_em&.rfc2822
        xml.link post_url(post.slug)
        xml.guid post_url(post.slug)
        xml.category post.categoria.nome
      end
    end
  end
end
