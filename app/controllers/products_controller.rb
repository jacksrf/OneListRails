class ProductsController < ApplicationController

require 'semantics3'
    # Your Semantics3 API Credentials
    API_KEY = 'SEM32501BF2A9CF5AAF82736C0F21889D901'
    API_SECRET = 'YjFhYWUxOWYwN2FmZDgzYTY3YzMxMjY1NDllZmE0ZWY'

def index
  @lists = List.where(user_id: session[:user_id])
  @groups = Group.where(creator_id: session[:user_id])
  @user = User.find_by(id: session[:user_id])
  @invites = Invite.where(email: @user.email, name: session[:username])
  @members = Member.where(name: session[:username])
  @items = Item.where(user_id: session[:user_id])
  @multiLists = MultiList.where(user_id: session[:user_id])
  @searchResults = []
  sem3 = Semantics3::Products.new(API_KEY,API_SECRET)
  sem3.products_field( "brand", params["search"] )
  @records = sem3.get_products()
  @sem3 = Semantics3::Products.new(API_KEY, API_SECRET)
  @records["results"].each do |product|
    productHash = {
      :upc => product["upc"],
      :sem3_id => product["sem3_id"],
      :name => product["name"],
      :model => product["model"],
      :brand => product["brand"],
      :color => product["color"],
      :sku => product["sitedetails"][0]["sku"],
      :seller => product["sitedetails"][0]["latestoffers"][0]["seller"],
      :price => product["sitedetails"][0]["latestoffers"][0]["price"],
      :url => product["sitedetails"][0]["url"]
    }
    @searchResults.push(productHash)
 end

end
end
