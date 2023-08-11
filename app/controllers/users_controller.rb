class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end
  def index
    @users = User.all
  end
  def new
    @flag=1
    @user = User.new
  end
  def edit
    @flag=0
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]  = "Your account information was succeessfully updated"
      redirect_to users_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the alpha blog #{@user.username}! You have successfully signed up"
      redirect_to users_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end