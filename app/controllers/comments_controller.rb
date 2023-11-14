class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      if request.referer.include?("comments")
        redirect_to item_comments_path(@item)
      else
        redirect_to item_path(@item)
      end
    else
      flash[:alert] = "コメントの投稿に失敗しました"
      @item.comments.delete(@comment)
      if request.referer.include?("comments")
        render 'comments/index'
      else
        render 'items/show'
      end
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:id])

    if @comment.user == current_user
      flash[:notice] = "コメントを削除しました"
      @comment.destroy
      if request.referer.include?("comments")
        redirect_to item_comments_path(@item)
      else
        redirect_to item_path(@item)
      end
    end
  end

  def index
    @item = Item.find(params[:item_id])
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def ensure_correct_user
    comment = Comment.find(params[:id])
    unless comment.user_id == current_user.id
      flash[:alert] = "権限がありません"
      redirect_to(root_path)
    end
  end
end
