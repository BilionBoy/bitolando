# Be sure to restart your server when you modify this file.

# Palavras em português — Rails usa inglês por padrão e confunde
# terminações latinas (categoria → categoria ao invés de categorias).
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular "categoria", "categorias"
  inflect.irregular "usuario",   "usuarios"
  # "status" é invariável em português — tabela é "statuses" (ok no Rails)
end
