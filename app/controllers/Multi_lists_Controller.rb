class MultiListsController < ApplicationController

def new
  @multiList = MultiList.new
  @group = Group.find_by(id: params[:group_id])
  @lists = List.where(user_id: session[:user_id])
  @MultiLists = MultiList.where(user_id: params[:user_id])
  @members = Member.where(name: params[:username])
  @groups = Group.where(creator_id: session[:user_id])
end

def show
  @multiList = MultiList.find_by(id: params[:id])
  @group = Group.find_by(id: @multiList.group_id)
  @list = List.find_by(id: @multiList.list_id)
  @items = Item.where(list_id: @list.id)
  @multiLists = MultiList.where(group_id: @group.id)
end

def create
  @multiList = MultiList.create(multi_params)
  @user = User.find_by(id: session[:user_id])
  @invite = Invite.find_by(group_id: params[:group_id], email: @user.email)
  @invite.destroy
  redirect_to '/'
end

private
  def multi_params
    params.require(:multi_list).permit(:list_id, :group_id, :user_id)
  end



end
