class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :update, :edit, :destroy]

  def index
    @prototypes = Prototype.order(created_at: :desc).page(params[:page]).per(5)
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
      flash.now[:error] = 'YNew prototype was unsuccessfully created'
      render :new
     end
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to "/" ,notice: 'updated now!'
    else
      redirect_to ({ action: new }), alert: 'YNew prototype was unsuccessfully created'
    end
  end

  def show
  end

  def destroy
    @prototype.destroy
    redirect_to :root, notice: 'prototype was successfully destroyed.'
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
      captured_images_attributes: [:content, :status]
    )
  end
end
