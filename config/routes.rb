Rails.application.routes.draw do
  # Saúde / PWA
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Autenticação admin via Devise
  devise_for :usuarios,
    path: "admin-login",
    path_names: { sign_in: "", sign_out: "sair" },
    controllers: { sessions: "admin/sessions" }

  # Admin
  namespace :admin do
    root "posts#index"
    resources :posts
    resources :categorias
    resources :imagens, only: %i[index create destroy]
  end

  # Site público
  root "posts#index"
  resources :posts, only: %i[index show], path: "posts"
  resources :categorias, only: %i[show], path: "categorias"

  get "sobre", to: "paginas#sobre", as: :sobre
  get "rss.xml", to: "paginas#rss", as: :rss_feed, defaults: { format: :xml }
  get "sitemap.xml", to: "paginas#sitemap", as: :sitemap, defaults: { format: :xml }

  # Páginas de erro personalizadas
  match "/404", to: "errors#not_found",             via: :all
  match "/422", to: "errors#unprocessable_entity",  via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # Catch-all — qualquer rota desconhecida → 404 personalizado
  match "*path", to: "errors#not_found", via: :all
end
