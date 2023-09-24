class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destory]
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def top
    @items = Item.all.order('created_at DESC').limit(9)
    @users = User.all.order('created_at DESC').limit(9)
  end

  def index
    case params[:order]
    when 'older'
      @items = Item.all.order('created_at ASC').page(params[:page]).per(24)
    when 'ranking'
      @items = Item.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC').page(params[:page]).per(24)
    when 'name_asc'
      @items = Item.order('LOWER(name) ASC').page(params[:page]).per(24)
    when 'name_desc'
      @items = Item.order('LOWER(name) DESC').page(params[:page]).per(24)
    when 'category_asc'
      @items = Kaminari.paginate_array(Item.all.sort_by { |g| g.category_list.first }).page(params[:page]).per(24)
    when 'category_desc'
      @items = Kaminari.paginate_array(Item.all.sort_by { |g| g.category_list.first }.reverse).page(params[:page]).per(24)
    else 'new'
      @items = Item.all.order('created_at DESC').page(params[:page]).per(24)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
    @comments = @item.comments.order('created_at ASC').limit(5)
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_url(@item), notice: "新規アイテムを登録しました"
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_url(@item), notice: "アイテム情報を更新しました"
    else
      render :new
    end
  end

  def destroy
    flash[:notice] = "アイテムを削除しました"
    @item.destroy
    respond_to do |format|
      format.html { redirect_to myitems_user_path(current_user.id), notice: "アイテムを削除しました" }
      format.json { head :no_content }
    end
  end

  def liked_users
    @item = Item.find(params[:id])
    @users = User.joins(:likes).where(likes: { item_id: @item.id }).order('likes.created_at DESC').page(params[:page])
  end

  def search_rakuten
    if params[:q].present?
      @rakuten_items = RakutenWebService::Ichiba::Item.search(keyword: params[:q])
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:user_id, :name, :start_date, :category_list, :detail, :image, :rakuten_url).merge(user_id:current_user.id)
    end

    def ensure_correct_user
      if @item.user_id != current_user.id
        flash[:alert] = "権限がありません"
        redirect_to item_path
      end
    end
end
