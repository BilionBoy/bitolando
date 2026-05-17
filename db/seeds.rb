# frozen_string_literal: true

# Status — tudo via FK, zero string hard-coded nos models
[
  { nome: "rascunho", posicao: 1 },
  { nome: "publicado", posicao: 2 },
  { nome: "agendado",  posicao: 3 }
].each do |attrs|
  Status.find_or_create_by!(nome: attrs[:nome]) do |s|
    s.posicao = attrs[:posicao]
  end
end

# Categorias
[
  { nome: "engenharia",  slug: "engenharia",  descricao: "sistemas, protocolos, trade-offs de baixo nível", posicao: 1 },
  { nome: "arquitetura", slug: "arquitetura",  descricao: "as decisões que o código não conta", posicao: 2 },
  { nome: "finanças",    slug: "financas",     descricao: "dinheiro, reserva, compounding na carreira", posicao: 3 },
  { nome: "gestão",      slug: "gestao",       descricao: "liderança, code review, mentoria", posicao: 4 },
  { nome: "produto",     slug: "produto",      descricao: "produto, UX, decisão sob incerteza", posicao: 5 }
].each do |attrs|
  Categoria.find_or_create_by!(slug: attrs[:slug]) do |c|
    c.nome      = attrs[:nome]
    c.descricao = attrs[:descricao]
    c.posicao   = attrs[:posicao]
  end
end

# Usuário admin padrão (só em dev — troque a senha antes de subir prod)
if Rails.env.development?
  Usuario.find_or_create_by!(email: "admin@bitolando.com") do |u|
    u.password              = "bitolando123"
    u.password_confirmation = "bitolando123"
  end
end

puts "Seeds OK: #{Status.count} status · #{Categoria.count} categorias · #{Usuario.count} usuário(s)"
