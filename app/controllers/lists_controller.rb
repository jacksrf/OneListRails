class ListsController < ApplicationController
  def index
    if session[:user_id]
      @lists = List.where(user_id: session[:user_id])
      @groups = Group.where(creator_id: session[:user_id])
      @user = User.find_by(id: session[:user_id])
      @invites = Invite.where(email: @user.email)
      @members = Member.where(name: session[:username])
    else
      redirect_to '/login'
    end
  end

  def show
    @list = List.find_by(id: params[:id])
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @items = @list.items
  end

  def new
    @list = List.new
  end

  def create
    @list = List.create(list_params)
    redirect_to '/'
  end

  private
    def list_params
      params.require(:list).permit(:name, :user_id)
    end

end
