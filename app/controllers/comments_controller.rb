class CommentsController < ApplicationController
	before_action :correct_user, only: [:edit, :update, :destroy]
	before_action :find_post, only: [:index, :create, :destroy]

	def index
		redirect_to post_path(@post)
	end

    def create
		@comment = @post.comments.build(comment_params)
		
		if !@comment.commenter.nil? && !@comment.text.nil? && @comment.commenter.size > 0 && @comment.text.size > 0
			@comment.save
			redirect_to post_path(@post)
		else
			redirect_to post_path(@post), notice: 'Invalid comment'
		end
 	end

	def destroy
		begin
			@comment = @post.comments.find(params[:id])
			@comment.destroy
			redirect_to post_path(@post)
		rescue ActiveRecord::RecordNotFound => e
			redirect_to '/500'
	  	end
	end

	def correct_user
        @comment = current_user.comments.find_by(id: params[:id])
		@post = current_user.posts.find_by(id: params[:post_id])
        redirect_to "/posts/#{params[:post_id]}", notice: "Not authorized" if @comment.nil? && @post.nil?
    end

private
	def comment_params
		params.require(:comment).permit(:commenter, :text, :user_id)
	end

	def find_post
		begin
			@post = Post.find(params[:post_id])
		rescue ActiveRecord::RecordNotFound => e
		  	redirect_to '/500'
		end
	end
end
