Rails.application.routes.draw do

	resources :posts do
		member do
			post 'like'
		end
		resources :comments
	end
	resources :categories

  	get 'welcome/index'

  	root 'welcome#index'
end
