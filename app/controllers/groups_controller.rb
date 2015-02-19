class GroupsController < ApplicationController

  def new
    @group = Group.new
    @lists = List.where(user_id: session[:user_id])
    @members = Member.where(name: params[:username])
    @groups = Group.where(creator_id: session[:user_id])
    @user = User.find_by(id: session[:user_id])
    @invites = Invite.where(email: @user.email)
  end

  def show
    @group = Group.find_by(id: params[:id])
    @members = Member.where(name: session[:username])
    @multiLists = MultiList.where(group_id: @group.id)
    @lists = List.where(user_id: session[:user_id])
    @list = List.find_by(id: @group.list_id)
    if @list == nil
      redirect_to edit_group_path
    end
    @groups = Group.where(creator_id: session[:user_id])
    @invites = Invite.where(group_id: @group.id)
  if params[:sort] == "price"
    @items = Item.where(list_id:@group.list_id).order('price ASC')
  elsif params[:sort] == "quantity"
    @items = Item.where(list_id:@group.list_id).order('quantity ASC')
  else
    @items = Item.where(list_id:@group.list_id)
  end
  end

  def create
    @list = List.find_by(user_id: session[:user_id])
    @members = Member.where(group_id: params[:id])
    @groups = Group.where(creator_id: session[:user_id])
    @group = Group.create(group_params)
    @multiList = MultiList.create(user_id: session[:user_id], list_id: @group.list_id, group_id: @group.id)
    redirect_to group_path(@group.id)
  end

  def update
    @group = Group.find_by(id: params[:group][:group_id])
    if @group.single_list == true
      @group.list_id = params[:group][:list_id]
      @group.save!
      redirect_to group_path(@group)
    end
    if @group.multi_list == true
      if @group.creator_id == session[:user_id]
        @group.list_id = params[:group][:list_id]
        @group.save!
        redirect_to group_path(@group)
      elsif @group.creator_id != session[:user_id]
        @multiList = MultiList.find_by(user_id: session[:user_id])
        @multiList.list_id = params[:group][:list_id]
        @multiList.save!
        redirect_to group_path(@group)
      end
    end
  end

  def edit
    @group = Group.find_by(id: params[:id])
    @members = Member.where(name: session[:username])
    @multiLists = MultiList.where(group_id: @group.id)
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @list = List.find_by(id: @group.list_id)
    @user = User.find_by(id: session[:user_id])
    @invites = Invite.where(email: @user.email)

  end

  def destroy
    @group = Group.find_by(id: params[:id])
    if @group.single_list == true
      @members = Member.where(group_id: params[:id])
      @members.each do |member|
        member.destroy
      end
      @invites = Invite.where(group_id: params[:id])
      @invites.each do |invite|
        invite.destroy
      end
      @group.destroy
      redirect_to '/'
    elsif @group.multi_list == true
      @multiLists = MultiList.where(group_id: params[:id])
      @multiLists.each do |multiList|
        multiList.destroy
      end
      @invites = Invite.where(group_id: params[:id])
      @invites.each do |invite|
        invite.destroy
      end
      @group.destroy
      redirect_to '/'
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, :creator_id, :single_list, :multi_list, :list_id, :subtitle)
    end

    def edit_params
      params.require(:item).permit(:quantity_bought)
    end

end
