class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @like = current_user.likes.create(item_id: params[:item_id])
    @custom_view = params[:custom_view]
    @like.save

    respond_to do |format|
      if @like.save
        format.html { redirect_to @item, notice: 'Liked the item.' }
        format.js
      else
        format.html { redirect_to @item, alert: 'Failed to like the item.' }
        format.js
      end
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @like = current_user.likes.find_by(item_id: params[:item_id])
    @custom_view = params[:custom_view]
    @like.destroy

    respond_to do |format|
      format.html { redirect_to @item, notice: 'Unliked the item.' }
      format.js
    end
  end
end
