class ItemsController < ApplicationController
require 'nokogiri'
require 'open-uri'
  def index
    @images = []
    @item = Item.find_by(id: params[:format])
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @user = User.find_by(id: session[:user_id])
    @invites = Invite.where(email: @user.email, name: session[:username])
    @members = Member.where(name: session[:username])

    doc = Nokogiri::HTML(open(@item.url))
    # doc.css('h1').each do |link|
    #   item = link.children
    # end
    doc.css('img').each do |link|
      if link.attributes["src"]
        image = link.attributes["src"].value
        @images.push(image)
      elsif link.attributes["data-src"]
        image = link.attributes["data-src"].value
        @images.push(image)
      end
    end
  end

  def new
    @list = List.find_by(user_id: session[:user_id])
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @members = Member.where(name: session[:username])
    @item = Item.new
  end

  def create
    @images = []
    @list = List.find_by(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @members = Member.where(name: session[:username])
    @item = Item.create(item_params)
    redirect_to items_path(@item)
  end

  def edit
    @list = List.find_by(id: params[:list_id])
    @item = Item.find_by(id: params[:id])
    @group = Group.find_by(list_id: params[:list_id])
    @lists = List.where(user_id: session[:user_id])
    @groups = Group.where(creator_id: session[:user_id])
    @members = Member.where(name: session[:username])
    if params[:type] == "image"
      url = params[:url]
      @item = Item.find_by(id: params[:id])
      @item.image_url = url
      @item.save
      redirect_to list_path(@item.list_id)
    end

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

        else
          newQuantity_bought = @item.quantity_bought.to_i + params[:item][:quantity_bought].to_i
          newQuantity = @item.quantity.to_i - params[:item][:quantity_bought].to_i
          newItem = Item.find_by(id: params[:id])
          newItem.quantity_bought = newQuantity_bought
          newItem.quantity = newQuantity
          newItem.save
          redirect_to group_path(@group)

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
      params.require(:item).permit(:name, :url, :list_id, :bought, :bought_id, :user_id, :quantity, :price)
    end

end
