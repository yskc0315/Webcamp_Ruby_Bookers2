class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: params[:id])
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to user_path(current_user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

  def users_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
