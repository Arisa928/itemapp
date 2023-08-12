class ItemsController < ApplicationController
  def top
    @items = Item.all.order('created_at DESC').limit(9)
    @users = User.all.order('created_at DESC').limit(9)
  end
end
