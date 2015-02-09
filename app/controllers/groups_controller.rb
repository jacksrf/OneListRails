class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def show
    @group = Group.find_by(id: params[:id])
    @members = Member.where(group_id: params[:id])
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @invites = Invite.where(group_id: params[:id])
  end

  def create
    @list = List.find_by(user_id: session[:user_id])
    @group = Group.create(group_params)
    redirect_to list_path(@lists)
  end

  private
    def group_params
      params.require(:group).permit(:name, :creator_id, :single_list, :multi_list)
    end

end
