class InvitesController < ApplicationController

def new
  @group = Group.find_by(id: params[:group_id])
  @lists = List.where(user_id: session[:user_id])
  @groups = Group.where(creator_id: session[:user_id])
  @invite = Invite.new
end

def create
  @invite = Invite.create(invite_params)
  redirect_to group_path(params[:group_id])
end

private
  def invite_params
    params.require(:invite).permit(:name, :email, :group_id, :admin)
  end

end
