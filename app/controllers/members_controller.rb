class MembersController < ApplicationController
  def new
    @member = Member.new
    @group = Group.find_by(id: params[:group_id])
    @lists = List.where(user_id: session[:user_id])
    @members = Member.where(name: params[:username])
    @groups = Group.where(creator_id: session[:user_id])
  end

  def create
    @member = Member.create(member_params)
    @user = User.find_by(id: session[:user_id])
    @invite = Invite.find_by(group_id: params[:group_id], email: @user.email)
    @invite.destroy
    redirect_to '/'
  end

  def destroy
    @member = Member.find_by(id: params[:id])
    @member.destroy
    redirect_to '/'
  end

  private
    def member_params
      params.require(:member).permit(:name, :group_id, :admin)
    end


end
