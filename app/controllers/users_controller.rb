class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    @items = Item.where(user_id: @user.id)
    @multiLists = MultiList.where(user_id: @user.id)
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @members = Member.where(user_id: session[:user_id])
    @invites = Invite.where(email: @user.email)
  end

  def create
    if params[:user][:password] == params[:user][:password_confirmation]
    @user = User.create(user_params)
      if @user.save
        UserNotifier.send_signup_email(@user).deliver
        session[:user_id] = @user.id
        session[:username] = @user.username
        redirect_to '/'
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @lists = List.where(user_id: session[:user_id])
    @members = Member.where(name: params[:username])
    @groups = Group.where(creator_id: session[:user_id])
    @user = User.find_by(id: session[:user_id])
    @multiLists = MultiList.where(user_id: session[:user_id])
    @invites = Invite.where(email: @user.email)
  end

  def update
    @user = User.find_by(id: params[:id])
    @user = User.update(user_update_params)
    redirect_to '/admin'
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @lists = List.where(user_id: @user.id)
    @lists.each do |list|
      @items = Item.where(list_id: list.id)
      @items.each do |item|
        item.destroy
      end
      list.destroy
    end
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
