class PostsController < ApplicationController

  before_action :find_post, only: [:edit, :update, :show, :destroy]

  # ===============CREATE========================
  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # @post.user = current_user
    
    if @post.save
      flash[:success] = "Question successfully created"
      redirect_to @post
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end




#==================READ================================

def index
  @posts = Post.order(created_at: :desc)
end

 
def show
  @comments = @post.comments.order(created_at: :desc)
  @comment = Comment.new
end

#===================UPDATE==========================
def edit
    
end

def update
  if @post.update(post_params)
    flash[:success] = "Post successfully updated"
    redirect_to @post
    
  else
    flash[:error] = "Something went wrong"
    render :edit
  end
end

  #================DELETE===========================
  def destroy
    @post.destroy
    redirect_to posts_path
  end





private

def find_post
  @post = Post.find params[:id]
end

def post_params   
  params.require(:post).permit(:title, :body)
end







end
