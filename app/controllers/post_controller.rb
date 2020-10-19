class PostController < ApplicationController
  def index
    @posts = Post.order('created_at desc')
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
    @post = Post.create(name: post_params[:name], annonce: post_params[:annonce], text: post_params[:text])

    if @post.errors.present?
      render :new
    else
      flash[:success] = 'Post added'
      redirect_to root_path
    end
  end

  def update
    created_at = DateTime.parse(post_params[:created_at])

    resource.update_attributes(
      name: post_params[:name],
      annonce: post_params[:annonce],
      text: post_params[:text],
      created_at: created_at
    )

    flash[:success] = 'Post changed'
    redirect_to post_path(resource.id)
  end

  def destroy
    resource.destroy
    flash[:success] = 'Post deleted'
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post)
  end

  def resource
    @resource ||= Post.find(params[:id])
  end
end
