class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :update, :edit, :destroy]

  def index
    @prototypes = Prototype.order("created_at DESC").page(params[:page]).per(12)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    tag_list = params[:tag_list].split(",")
    if @prototype.save
      @prototype.save_tags(tag_list)
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      flash.now[:error] = 'New prototype was unsuccessfully created'
      render :new
    end
  end

  def edit
    @prototype.captured_images.build
    @tag_list = @prototype.tags.pluck(:tag).join(",")
  end

  def update
    tag_list = params[:tag_list].split(",")
    if @prototype.update_attributes(prototype_params)
      @prototype.save_tags(tag_list)
      redirect_to prototype_path, notice: 'Updated now!'
    else
      flash.now[:error] = 'Prototype was unsuccessfully updated'
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.order(id: "DESC").includes(:user)
  end

  def destroy
    @prototype.destroy
    redirect_to user_path(current_user), notice: 'Prototype was successfully destroyed.'
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :id]
    )
  end
end
