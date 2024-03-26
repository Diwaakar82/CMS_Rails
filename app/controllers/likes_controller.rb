class LikesController < ApplicationController
    before_action :find_post
    before_action :find_like, only: [:destroy]

    def create
        if already_liked?
            flash[:notice] = "You can't like more than once"
        else
            @post.likes.create(user_id: current_user.id)
        end
        redirect_to posts_path
    end
    
    def destroy
        # find_like
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @like.destroy
        end
        redirect_to posts_path
    end
    
private
    def find_post
        begin
            @post = Post.find(params[:post_id])
        rescue ActiveRecord::RecordNotFound => e
            redirect_to '/500'
        end
        
    end

    def find_like
        begin
            @like = @post.likes.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            redirect_to '/500'
        end
     end

    def already_liked?
        Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end
end
