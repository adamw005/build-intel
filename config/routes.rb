Rails.application.routes.draw do
	mount Blazer::Engine, at: "/"

	require 'sidekiq/web'
	mount Sidekiq::Web => '/sidekiq'
end
