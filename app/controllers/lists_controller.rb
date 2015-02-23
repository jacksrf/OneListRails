class ListsController < ApplicationController
  def index
    if session[:user_id]
      @lists = List.where(user_id: session[:user_id])
      @groups = Group.where(creator_id: session[:user_id])
      @user = User.find_by(id: session[:user_id])
      @invites = Invite.where(email: @user.email, name: session[:username])
      @members = Member.where(name: session[:username])
      @items = Item.where(user_id: session[:user_id])
      @multiLists = MultiList.where(user_id: session[:user_id])
    else
      redirect_to '/login'
    end
  end

  def show
    if params[:type] == "firstList"
    @list = List.find_by(user_id: params[:id].to_i)
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @multiLists = MultiList.where(user_id: session[:user_id])
    @members = Member.where(name: session[:username])
    @items = Item.where(list_id: @list.id)
    @user = User.find_by(id: session[:user_id])
    @invites = Invite.where(email: @user.email)
  else
    @list = List.find_by(id: params[:id].to_i)
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @multiLists = MultiList.where(user_id: session[:user_id])
    @members = Member.where(name: session[:username])
    @items = Item.where(list_id: @list.id)
    @user = User.find_by(id: session[:user_id])
    @invites = Invite.where(email: @user.email)
  end
  end

  def new
    @list = List.new
    @lists = List.where(user_id: session[:user_id])
    @members = Member.where(name: params[:username])
    @groups = Group.where(creator_id: session[:user_id])
    @multiLists = MultiList.where(user_id: session[:user_id])
    @user = User.find_by(id: session[:user_id])
    @invites = Invite.where(email: @user.email)
  end

  def create
    @list = List.create(list_params)
    redirect_to '/'
  end

  def destroy
    @list = List.find_by(id: params[:id])
    @items = Item.where(list_id: @list.id)
    @items.each do |item|
      item.destroy
    end
    @list.destroy
    redirect_to '/'
  end

  private
    def list_params
      params.require(:list).permit(:name, :user_id)
    end

end
