class InvitesController < ApplicationController

def new
  @group = Group.find_by(id: params[:group_id])
  @members = Member.where(name: params[:username])
  @lists = List.where(user_id: session[:user_id])
  @groups = Group.where(creator_id: session[:user_id])
  @invite = Invite.new
end

def index
  @lists = List.where(user_id: session[:user_id])
  @groups = Group.where(creator_id: session[:user_id])
  @members = Member.where(name: session[:username])
  @user = User.find_by(id: session[:user_id])
  @invites = Invite.where(email: @user.email)
end

def create
  @invite = Invite.create(invite_params)
  @group = Group.find_by(id: invite_params[:group_id])
  @user = User.find_by(id: @group.creator_id)
  redirect_to group_path(params[:group_id])
end

def destroy
  @invite = Invite.find_by(id: params[:id])
  @invite.destroy
  redirect_to group_path(params[:group_id])
end

private
  def invite_params
    params.require(:invite).permit(:name, :email, :group_id, :admin)
  end

end
