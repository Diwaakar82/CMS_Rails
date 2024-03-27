Rails.application.routes.draw do

  	get "sign_up", to: "users#new", as: :sign_up
	post "sign_up", to: "users#create"
	get "login", to: "sessions#new", as: :login
	post "login", to: "sessions#create"
	delete "logout", to: "sessions#destroy", as: :logout
	get "edit_profile", to: "users#edit"
	patch "edit_profile", to: "users#update"

	resources :posts do
		resources :likes
		resources :comments
	end

	resources :categories, except: [:show] do
		get 'posts/:id', to: 'categories#show', on: :collection, as: :category_posts 
	end


  	get 'welcome/index'
	get 'users/:user_id/my_posts', to: 'posts#my_posts'

	root 'welcome#index', as: :authenticated_root

	get '*path', to: 'application#page_not_found'
end
