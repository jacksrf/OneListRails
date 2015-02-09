class ItemsController < ApplicationController

  def new
    @list = List.find_by(user_id: session[:user_id])
    @item = Item.new
  end

  def create
    @list = List.find_by(user_id: session[:user_id])
    @item = Item.create(item_params)
    redirect_to list_path(@list)
  end

  private
    def item_params
      params.require(:item).permit(:name, :url, :price, :list_id, :bought)
    end

end
