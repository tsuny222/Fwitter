class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit,:update,:destroy]}
  def show
  	@user = User.find(params[:id])
  	@posts = @user.posts.page(params[:page]).reverse_order
    @users = User.page(params[:page]).reverse_order
  end

  def index
  	@user = User.all
    @users = User.page(params[:page]).reverse_order
  end

  def edit
  	@user = User.find(params[:id])
  end
  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	redirect_to user_path(@user)
  else
    render :edit
  end
  end
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).reverse_order
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).reverse_order
    render 'show_follow'
  end

  private
   def ensure_correct_user
    @user = User.find(params[:id])
    if current_user != @user
    redirect_to user_path(current_user.id)
  end
  end
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
