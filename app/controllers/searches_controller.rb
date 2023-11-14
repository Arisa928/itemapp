class SearchesController < ApplicationController
  def index
    @q = params[:q]
    @model = params[:model].presence || 'items'
    if @q.present?
      case @model
      when 'users'
        @users = User.ransack(name_or_introduction_cont: @q).result(distinct: true)
      when 'items'
        @items = Item.ransack(name_or_detail_cont: @q).result(distinct: true)
      when 'categories'
        @items = Item.tagged_with(@q)
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
