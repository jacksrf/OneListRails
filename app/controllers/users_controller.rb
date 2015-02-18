class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    @lists = List.where(user_id: params[:id])
  end

  def create
    @user = User.create(user_params)
    if @user.save
      UserNotifier.send_signup_email(@user).deliver
      redirect_to '/'
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user = User.update(user_update_params)
    redirect_to '/admin'
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to '/admin'
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :first_name, :last_name, :address, :address2, :city, :state, :zip, :email, :phone)
    end

    def user_update_params
      params.require(:user).permit(:username, :first_name, :last_name, :address, :address2, :city, :state, :zip, :email, :phone)
    end

end
