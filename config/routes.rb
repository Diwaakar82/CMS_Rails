Rails.application.routes.draw do

  devise_for :users
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
