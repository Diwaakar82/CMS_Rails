class CommentsController < ApplicationController
	before_action :correct_user, only: [:edit, :update, :destroy]

    def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)

		redirect_to post_path(@post)
 	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
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

end
