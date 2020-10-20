class CommentController < ApplicationController
  before_action :authenticate_user!
  before_action :expires_require, only: [:edit, :update, :destroy]
  before_action :user_require, only: [:edit, :update, :destroy]

  EXPIRES_TIME = 15.minutes

  def create
    Comment.create(
      post_id: post_id,
      text: comment_params[:text],
      user_id: current_user.id,
      expires_at: EXPIRES_TIME.from_now
    )

    flash[:success] = I18n.t('controllers.comment.create')

    redirect_to post_path(post_id)
  end

  def edit
    @comment = resource
    @post_id = post_id
  end

  def update
    @comment = resource
    @comment.text = comment_params[:text]
    @comment.save

    if @comment.errors.present?
      @post_id = post_id
      render :edit
    else
      flash[:success] = I18n.t('controllers.comment.update')
      redirect_to post_path(post_id)
    end
  end

  def destroy
    resource.destroy
    flash[:success] = I18n.t('controllers.comment.destroy')
    redirect_to post_path(post_id)
  end

  private

  def expires_require
    if DateTime.current > resource.expires_at
      redirect_to post_path(post_id)
    end
  end

  def user_require
    if current_user != resource.user
      redirect_to post_path(post_id)
    end
  end

  def resource
    @resource ||= Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment)
  end

  def post_id
    params[:post_id]
  end
end
