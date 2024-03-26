class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update, :destroy]
    before_action :find_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end
    
    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
            create_or_delete_posts_categories(@post, post_params[:category_ids])

            redirect_to @post
        else
            render 'edit'
        end
    end

    def new
        @post = current_user.posts.build
    end
    
    def create
        @post = current_user.posts.build(post_params)
        create_or_delete_posts_categories(@post, post_params[:category_ids])

        if @post.save
            redirect_to @post
        else
            render 'new'
        end
    end
    
    def destroy
        @post.destroy

        redirect_to posts_path
    end

    def my_posts
        @post = Post.find_by(user_id: params[:user_id])
    end

    def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        redirect_to posts_path, notice: "Not authorized" if @post.nil?
    end

private
    def create_or_delete_posts_categories(post, categories)
        post.categories.destroy_all
        
        unless categories.nil?
            categories.each do |category|
                if category.present?
                    new_category = Category.find(category)
        
                    post.categories << new_category
                end
            end
        end
    end

    def post_params
        params.require(:post).permit(:title, :description, :user_id, :category_ids => [])
    end

    def find_post
        begin 
            @post = Post.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            redirect_to '/500'
        end
    end
end
