class PostController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :my_posts]
  before_action :user_required, only: [:edit, :update, :destroy]
  PER_PAGE = 5

  def index
    @posts = Post.active.includes(:user).order('created_at desc')
    @posts = @posts.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def show
    @post = resource
  end

  def edit
    @post = resource
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(
      active: post_params[:active],
      name: post_params[:name],
      annonce: post_params[:annonce],
      text: post_params[:text],
      user_id: current_user.id
    )

    if @post.errors.present?
      render :new
    else
      flash[:success] = 'Post added'
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

    if @post.errors.present?
      render :edit
    else
      flash[:success] = 'Post changed'
      redirect_to post_path(resource.id)
    end
  end

  def destroy
    resource.destroy
    flash[:success] = 'Post deleted'
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

  def resource
    @resource ||= Post.find(params[:id])
  end
end
