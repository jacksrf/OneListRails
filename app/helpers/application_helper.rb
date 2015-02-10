module ApplicationHelper
  def options_for_seasons
    lists = List.where(user_id: session[:user_id])
    newLists = []
    lists.each do |list|
      newLists.push([list.name,list.id])
    end
    return newLists
  end

end
