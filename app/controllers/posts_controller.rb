class PostsController < ApplicationController
    before_action :user_signed_in?, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update, :destroy]
    before_action :find_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def show
    end
    
    def edit
    end

    def update
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

        redirect_to request.referer.present? ? request.referer : posts_path
    end

    def my_posts
        @post = Post.find_by(user_id: params[:user_id])
    end

    def correct_user
        @post = current_user.posts.find_by(id: params[:id]) unless current_user.nil?
        redirect_to request.referer.present? ? request.referer : posts_path, notice: "Not authorized" if @post.nil?
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
