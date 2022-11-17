class CommentsController < ApplicationController

    before_action :find_post
    before_action :authenticate_user!
    # before_action :authorize_user!, only: [:destroy]

    def create
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
          flash[:success] = "Comments successfully created"
          redirect_to @post
        else
          @comments = @post.comments.order(created_at: :desc)
          render '/posts/show', status: 303
        end
      end

  def destroy
    @comment = Comment.find params[:id]
    if can?(:crud, @comment)
      @comment.destroy
      redirect_to post_path(@comment.post)
      flash[:success] = "Comment deleted"
    else
        redirect_to root_path, alert: "Not athorized to change Comment!"
      end
    
  end


    private

    def find_post
      @post = Post.find params[:post_id]
    end
   
    def comment_params
      params.require(:comment).permit(:body)
    end

#      def authorize_user!
#     redirect_to root_path, alert: "Not authorized!" unless can?(:crud, @comment)
#   end


end













