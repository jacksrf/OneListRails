class GroupsController < ApplicationController

  def new
    @group = Group.new
    @lists = List.where(user_id: session[:user_id])
    @members = Member.where(name: params[:username])
    @groups = Group.where(creator_id: session[:user_id])
  end

  def show
    @group = Group.find_by(id: params[:id])
    @members = Member.where(name: session[:username])
    @lists = List.where(user_id: session[:user_id])
    @list = List.find_by(id: @group.list_id)
    @groups = Group.where(creator_id: session[:user_id])
    @invites = Invite.where(group_id: params[:id])
    @items = Item.where(list_id:@group.list_id)
  end

  def create
    @list = List.find_by(user_id: session[:user_id])
    @members = Member.where(group_id: params[:id])
    @groups = Group.where(creator_id: session[:user_id])
    @group = Group.create(group_params)
    redirect_to group_path(@group.id)
  end

  def destroy
    @group = Group.find_by(id: params[:id])
    @group.destroy
    @members = Member.where(group_id: params[:id])
    @members.each do |member|
      member.destroy
    end
    @invites = Invite.where(group_id: params[:id])
    @invites.each do |invite|
      invite.destroy
    end
    redirect_to '/'
  end

  private
    def group_params
      params.require(:group).permit(:name, :creator_id, :single_list, :multi_list, :list_id)
    end

end
