Rails.application.routes.draw do
  get 'dashboard/show'

  # ... new
  post 'dashboard/control'
  get 'build_finishes/index', as: 'build_finishes'

  get "home/welcome", :as => :welcome
  get 'home/index'

  root :to => "home#index"

  devise_for :users

	mount Blazer::Engine, at: "/blazer"

	require 'sidekiq/web'
	mount Sidekiq::Web => '/sidekiq'

  # Chartkick Dashboards for AJAX
  get 'dashboard/three_line', as: 'dashboard_three_line'
  get 'dashboard/brand_column', as: 'dashboard_brand_column'
  get 'dashboard/scrape_count', as: 'dashboard_scrape_count'
  get 'dashboard/price_popup/:sku', to: 'dashboard#price_popup', as: 'dashboard_price_popup'

  get 'prices/index', as: 'prices'

  # Uploads Routes
  resources :uploads

end
