class TagController < ApplicationController
  before_action :authenticate_user!

  def index
    @tags = Tag.order_by_name
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = resource
  end

  def create
    @tag = Tag.create(name: tag_params[:name])

    if @tag.errors.present?
      render :new
    else
      flash[:success] = I18n.t('controllers.tag.create')
      redirect_to tags_path
    end
  end

  def destroy
    resource.destroy
    flash[:success] = I18n.t('controllers.tag.destroy')
    redirect_to tags_path
  end

  def update
    @tag = resource

    @tag.name = tag_params[:name]
    @tag.save

    if @tag.errors.present?
      render :edit
    else
      flash[:success] = I18n.t('controllers.tag.update')
      redirect_to tags_path
    end
  end

  private

  def tag_params
    params.require(:tag)
  end

  def resource
    @resource ||= Tag.find(params[:id])
  end
end
