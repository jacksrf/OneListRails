class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
    @lists = List.where(user_id: session[:user_id])
    @members = Member.where(name: params[:username])
    @groups = Group.where(creator_id: session[:user_id])
    @user = User.find_by(id: session[:user_id])
    @invites = Invite.where(email: @user.email)
  end

  def create
    user = User.find_by(id: session[:user_id])
    if user.authenticate(params[:profile][:current_password])
      if params[:profile][:new_password] == params[:profile][:confirm_password]
        user.password = params[:profile][:new_password]
        user.save!
        redirect_to '/login'
      end
    end
  end
end
