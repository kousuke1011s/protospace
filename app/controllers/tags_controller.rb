class TagsController < ApplicationController
  before_action :set_tag, only: [:show]

  def index
    @tags = Tag.order("created_at DESC").all
  end

  def show
    @prototypes = @tag.prototypes.page(params[:page]).per(12)
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
