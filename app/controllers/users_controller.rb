class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit_profile, :account]
  before_action :ensure_correct_user, only: [:edit_profile, :account]

  def index
    case params[:order]
    when 'older'
      @users = User.all.order('created_at ASC').page(params[:page]).per(24)
    when 'name_asc'
      @users = User.order('LOWER(name) ASC').page(params[:page]).per(24)
    when 'name_desc'
      @users = User.order('LOWER(name) DESC').page(params[:page]).per(24)
    else 'new'
      @users = User.all.order('created_at DESC').page(params[:page]).per(24)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show_myitems
    @user = User.find(params[:id])
    @items = @user.items
  end

  def edit_profile
    @user = User.find(current_user.id)
  end

  def account
    @user = User.find(current_user.id)
  end

  private

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:alert] = "権限がありません"
      redirect_to root_path
    end
  end
end
