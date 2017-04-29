Rails.application.routes.draw do
	mount Blazer::Engine, at: "blazer"
	root to: "blazer"
end
