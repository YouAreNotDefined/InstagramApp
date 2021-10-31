class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:profile]

  def index
    followers_ids = Follower.where(follower_id: current_user.id).pluck(:following_id)
    followers_ids << current_user.id

    @posts = Post.includes(:user).where(user_id: followers_ids).active

    following_ids = Follower.where(follower_id: current_user.id).pluck(:following_id)
    following_ids << current_user.id

    @follower_suggestions = User.where.not(id: following_ids)
  end

  def profile
    @posts = current_user.posts.active
  end

  def follow
    follower_id = params[:follow_id]
    if Follower.create(follower_id: current_user.id, following_id: follower_id)
      render status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by_username(params[:username])
  end
end
