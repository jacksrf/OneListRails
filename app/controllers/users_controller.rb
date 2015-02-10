class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to '/'
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user = User.update(user_params)
    redirect_to '/admin'
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :first_name, :last_name, :address, :address2, :city, :state, :zip, :email, :phone)
    end

end
