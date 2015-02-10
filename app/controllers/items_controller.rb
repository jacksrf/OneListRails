class ItemsController < ApplicationController

  def new
    @list = List.find_by(user_id: session[:user_id])
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @members = Member.where(name: session[:username])
    @item = Item.new
  end

  def create
    @list = List.find_by(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @members = Member.where(name: session[:username])
    @item = Item.create(item_params)
    binding.pry
    redirect_to list_path(@list)
  end

  def update
    @list = List.find_by(id: params[:list_id])
    @item = Item.find_by(id: params[:id])
    @group = Group.find_by(list_id: params[:list_id])
    if @item.bought == false
      @item.bought = true
      @item.bought_id = session[:user_id]
      @item.save
    elsif @item.bought == true
      @item.bought = false
      @item.bought_id = nil
      @item.save
    end
    redirect_to group_path(@group)

  end

  def destroy
    @item = Item.find_by(id: params[:id])
    @group = Group.find_by(list_id: params[:list_id])
    @item.destroy
    binding.pry
    redirect_to :back
  end


  private
    def item_params
      params.require(:item).permit(:name, :url, :price, :list_id, :bought, :bought_id, :user_id)
    end

end
