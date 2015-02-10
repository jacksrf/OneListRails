class InvitesController < ApplicationController

def new
  @group = Group.find_by(id: params[:group_id])
  @lists = List.where(user_id: session[:user_id])
  @groups = Group.where(creator_id: session[:user_id])
  @invite = Invite.new
end

def create
  @invite = Invite.create(invite_params)
  @group = Group.find_by(id: invite_params[:group_id])
  @user = User.find_by(id: @group.creator_id)
  puts "start"
  Pony.mail(:to => "jacksrf@gmail.com" , :from => 'admin@onelist.com', :subject => 'You were invited to a Group!', :body => "You were invited to group: " + @group.name + " by: " + @user.username + "! Login to accept or decline!" )
  puts "finish"
  binding.pry
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
