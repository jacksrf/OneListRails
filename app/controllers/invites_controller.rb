class InvitesController < ApplicationController

def new
  @group = Group.find_by(id: params[:group_id])
  @members = Member.where(name: params[:username])
  @lists = List.where(user_id: session[:user_id])
  @groups = Group.where(creator_id: session[:user_id])
  @user = User.find_by(id: session[:user_id])
  @invites = Invite.where(email: @user.email)
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
  @invites = Invite.where(group_id: params[:invite][:group_id], email: params[:invite][:email])
  if @invites.length == 0
    @invite = Invite.create(invite_params)
    @group = Group.find_by(id: invite_params[:group_id])
    @user = User.find_by(id: @group.creator_id)
    UserNotifier.send_invite_email(@invite, @user).deliver
    redirect_to group_path(params[:group_id])
  else
    redirect_to :back
  end
end

def destroy
  @invite = Invite.find_by(id: params[:id])
  if @invite.present?
    @invite.destroy
  end
  redirect_to group_path(params[:group_id])
end

private
  def invite_params
    params.require(:invite).permit(:name, :email, :group_id, :admin)
  end

end
