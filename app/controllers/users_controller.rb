class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    if current_user.id !=  params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice: 'User was successfully updated!'
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:introduction, :profile_image, :name)
  end


end