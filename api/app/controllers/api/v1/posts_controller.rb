class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show]

  def show
    @comments = Comment.includes(:user).where(post_id: @post.id)
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id]) if params[:id].present?
  end


  def post_params
    params.require(:post).permit(:description, :image, :image_cache)
  end

end
