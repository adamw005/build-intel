Rails.application.routes.draw do
  get 'dashboard/show'

  get "home/welcome", :as => :welcome
  resources :members
  get 'home/index'

   root :to => "home#index"


  # *MUST* come *BEFORE* devise's definitions (below)
  as :user do
    match '/user/confirmation' => 'milia/confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => {
    :registrations => "milia/registrations",
    :confirmations => "milia/confirmations",
    :sessions => "milia/sessions",
    :passwords => "milia/passwords",
  }


	mount Blazer::Engine, at: "/blazer"

	require 'sidekiq/web'
	mount Sidekiq::Web => '/sidekiq'

  # Chartkick Dashboards for AJAX
  get 'dashboard/three_line', as: 'dashboard_three_line'
  get 'dashboard/brand_column', as: 'dashboard_brand_column'
  get 'dashboard/scrape_count', as: 'dashboard_scrape_count'
  get 'dashboard/price_popup/:sku', to: 'dashboard#price_popup', as: 'dashboard_price_popup'

  # Uploads Routes
  resources :uploads

end
