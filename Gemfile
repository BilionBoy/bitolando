source "https://rubygems.org"

gem "rails", "~> 8.1.3"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# Autenticação
gem "devise"

# Paginação — mesma versão do Frotas MVC
gem "pagy", "~> 6.5"

# Markdown com syntax highlight
gem "redcarpet"

# Processamento de imagens (Active Storage variants)
gem "image_processing", "~> 1.2"

# Formulários com wrappers
gem "simple_form"

# Busca/filtros
gem "ransack"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
