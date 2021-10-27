class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    followers_ids = Follower.where(follower_id: current_user.id).pluck(:following_id)
    followers_ids << current_user.id

    @posts = Post.includes(:user).where(user_id: followers_ids).active
    @comment = Comment.new

    following_ids = Follower.where(follower_id: current_user.id).pluck(:following_id)
    following_ids << current_user.id

    @follower_suggestions = User.where.not(id: following_ids)
  end

  def show
    @posts = current_user.posts.active
  end

  def follow_user
    follower_id = params[:follow_id]
    if Follower.create(follower_id: current_user.id, following_id: follower_id)
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end
end
