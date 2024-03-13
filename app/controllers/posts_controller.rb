class PostsController < ApplicationController
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
            redirect_to @post
        else
            render 'edit'
        end
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params.except(:categories))
        @post.likes = 0

        create_or_delete_posts_categories(@post, params[:post][:categories])
        
        @post.save
        redirect_to @post
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to posts_path
    end

private
    def create_or_delete_posts_categories(post, categories)
        # post.categories_posts.destroy_all
        categories = categories.strip.split(", ")
        
        categories.each do |category|
            post.categories << Category.find_or_create_by(title: category)
        end
        
    end


    def post_params
        params.require(:post).permit(:title, :description, :categories)
    end
end
