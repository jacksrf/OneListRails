class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to '/'
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :first_name, :last_name, :address, :address2, :city, :state, :zip, :email, :phone)
    end

end
