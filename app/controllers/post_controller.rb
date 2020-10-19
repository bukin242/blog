class PostController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :my_posts]
  before_action :user_required, only: [:edit, :update, :destroy]
  PER_PAGE = 5

  def index
    @posts = Post.active.includes(:user).order('created_at desc')

    if tag_id
      @posts = @posts.joins(:post_tags).where("post_tags.tag_id = #{tag_id}")
    end

    @posts = @posts.paginate(page: params[:page], per_page: PER_PAGE)

    @tags = Tag.order_by_name
  end

  def show
    @post = resource
    @comment = Comment.new
    @comments = Comment.where(post_id: resource.id).order('created_at desc')
  end

  def edit
    @post = resource
    @tags = Tag.order_by_name
    @tags_selected = resource.tags.pluck(:id)
  end

  def new
    @post = Post.new
    @tags = Tag.order_by_name
  end

  def create
    @post = Post.create(
      active: post_params[:active],
      name: post_params[:name],
      annonce: post_params[:annonce],
      text: post_params[:text],
      user_id: current_user.id
    )

    if params[:tags]
      params[:tags].each do |tag_id|
        @post.post_tags.create(tag_id: tag_id)
      end
    end

    if @post.errors.present?
      render :new
    else
      Rails.cache.clear

      flash[:success] = I18n.t('controllers.post.create')
      redirect_to root_path
    end
  end

  def update
    created_at = DateTime.parse(post_params[:created_at])

    @post = resource

    @post.name = post_params[:name]
    @post.annonce = post_params[:annonce]
    @post.text = post_params[:text]
    @post.created_at = created_at
    @post.save

    if params[:tags]
      @post.post_tags.destroy_all
      params[:tags].each do |tag_id|
        @post.post_tags.create(tag_id: tag_id)
      end
    end

    if @post.errors.present?
      render :edit
    else
      Rails.cache.clear

      flash[:success] = I18n.t('controllers.post.update')
      redirect_to post_path(resource.id)
    end
  end

  def destroy
    resource.destroy
    Rails.cache.clear

    flash[:success] = I18n.t('controllers.post.destroy')
    redirect_to root_path
  end

  def my_posts
    @posts = Post.includes(:user).where(user_id: current_user.id).order('created_at desc')
    @posts = @posts.paginate(page: params[:page], per_page: PER_PAGE)
  end

  private

  def user_required
    if resource.user != current_user
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post)
  end

  def tag_id
    params[:tag]
  end

  def resource
    @resource ||= Post.find(params[:id])
  end
end
