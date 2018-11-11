class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :update, :edit, :destroy]

  def index
    @prototypes = Prototype.order("created_at DESC").page(params[:page]).per(4)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      flash.now[:error] = 'New prototype was unsuccessfully created'
      render :new
    end
  end

  def edit
    @prototype.captured_images.build
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path, notice: 'Updated now!'
    else
      flash.now[:error] = 'Prototype was unsuccessfully updated'
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.order(id: "DESC")
  end

  def destroy
    @prototype.destroy
    redirect_to :root, notice: 'Prototype was successfully destroyed.'
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
