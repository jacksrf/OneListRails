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
    redirect_to list_path(@list)
  end

  def edit
    @list = List.find_by(id: params[:list_id])
    @item = Item.find_by(id: params[:id])
    @group = Group.find_by(list_id: params[:list_id])
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @members = Member.where(name: session[:username])
  end

  def update
    if params[:item][:type] == "edit"
      @list = List.find_by(id: params[:list_id])
      @item = Item.find_by(id: params[:id])
      @group = Group.find_by(list_id: params[:list_id])
      @item.update(item_params)
      redirect_to list_path(@list.id)
    elsif params[:item][:type] == "quantity"
      @item = Item.find_by(id: params[:id])
      @list = List.find_by(id: @item.list_id)
      @group = Group.find_by(list_id: @list.id)
      @item.update(item_params)

      bought = @item.quantity_bought

        if bought == nil
          newQuantity_bought = params[:item][:quantity_bought]
          newQuantity = @item.quantity.to_i - params[:item][:quantity_bought].to_i
          newItem = Item.find_by(id: params[:id])
          newItem.quantity_bought = newQuantity_bought.to_i
          newItem.quantity = newQuantity.to_i
          newItem.save
          redirect_to group_path(@group)
          binding.pry
        else
          newQuantity_bought = @item.quantity_bought.to_i + params[:item][:quantity_bought].to_i
          newQuantity = @item.quantity.to_i - params[:item][:quantity_bought].to_i
          newItem = Item.find_by(id: params[:id])
          newItem.quantity_bought = newQuantity_bought
          newItem.quantity = newQuantity
          newItem.save
          redirect_to group_path(@group)
          binding.pry
      end
    else
      @list = List.find_by(id: params[:id])
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
    redirect_to :back
  end

  end

  def destroy
    @item = Item.find_by(id: params[:id])
    @group = Group.find_by(list_id: params[:list_id])
    @item.destroy
    redirect_to :back
  end


  private
    def item_params
      params.require(:item).permit(:name, :url, :price, :list_id, :bought, :bought_id, :user_id, :quantity)
    end

end
