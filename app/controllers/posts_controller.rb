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

        if @post.update(post_params.except(:category_ids))
            create_or_delete_posts_categories(@post, post_params[:category_ids])

            puts @post.categories
            redirect_to @post
        else
            render 'edit'
        end
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.likes = 0
        
        @post.save
        redirect_to @post
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to posts_path
    end

    def like
        @post = Post.find(params[:id])
        @post.increment!(:likes) if @post
    
        respond_to do |format|
          format.json { render json: { likes: @post.likes } }
        end
    end

private
    def create_or_delete_posts_categories(post, categories)
        post.categories.destroy_all

        categories.each do |category|
            if category != ""
                new_category = Category.find(category)
    
                post.categories << Category.find_or_create_by(title: new_category[:title])
            end
        end
        
    end


    def post_params
        params.require(:post).permit(:title, :description, :likes, :category_ids => [])
    end
end
