class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(post_id: params[:post_id])
    @post_id = params[:post_id]
    existing_like = current_user.likes.where(post_id: params[:post_id])

    if existing_like.any?
      existing_like.first.destroy
    elsif @like.save
      render status: :ok
    else
      render status: :unprocessable_entity
    end

    @post_likes = Post.find(@post_id).total_likes_count
  end
end
