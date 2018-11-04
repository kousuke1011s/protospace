class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :move_to_sign_in
  before_action :confirm_current_user, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.prototype_id = params[:prototype_id]
    if @comment.save
      render :index #index.js.erb
    end
  end

  def update
    if @comment.update(comment_params)
      render :index
    end
  end

  def destroy
    if @comment.destroy
      render :index
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :prototype_id)
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def move_to_sign_in
    redirect_to root_path unless user_signed_in?
  end
  def confirm_current_user
    redirect_to root_path unless current_user == @comment.user
  end
end
