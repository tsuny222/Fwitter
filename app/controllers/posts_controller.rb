class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}
  def new
  	@post = Post.new
  end
  def create
  	@post = Post.new(post_params)
    @post.user_id = current_user.id
  	if @post.save
  	redirect_to post_path(@post)
  else
  	render :new
  end
  end
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @like = Like.new
     @users = User.page(params[:page]).reverse_order
  end
  def index
  	@posts = Post.all
    @post_comment = PostComment.new
    @like = Like.new
     @users = User.page(params[:page]).reverse_order
  end

  def edit
  	@post = Post.find(params[:id])
  end
  def update
  	@post = Post.find(params[:id])
  	if @post.update(post_params)
  		redirect_to post_path(@post)
  	else
  		render :edit
  	end
  end
  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
  	redirect_to posts_path
  end

  private
  def ensure_correct_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
    redirect_to posts_path
    end
  end
  def post_params
  	params.require(:post).permit(:body, :image, :user_id)
  end
end
