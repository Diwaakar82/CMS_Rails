Rails.application.routes.draw do

  devise_for :users
	resources :posts do
		resources :likes
		resources :comments
	end

	resources :categories, except: [:show] do
		get 'posts/:id', to: 'categories#show', on: :collection, as: :category_posts 
	end


  	get 'welcome/index'
	get 'users/:user_id/my_posts', to: 'posts#my_posts'
  	
	devise_scope :user do
		authenticated :user do
			root 'welcome#index', as: :authenticated_root
		end
		
		unauthenticated do
			root 'devise/sessions#new', as: :unauthenticated_root
		end
	end

	get '*path', to: 'application#page_not_found'
end
