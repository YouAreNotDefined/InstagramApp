module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        following_ids = Follower.where(follower_id: current_api_v1_user.id).pluck(:following_id)
        following_ids << current_api_v1_user.id

        @posts = Post.includes(:user).where(user_id: following_ids).active
        @follow_suggestions = User.where.not(id: following_ids)
      end

      def profile
        @user = current_api_v1_user
        @posts = current_api_v1_user.posts.active
      end

      def follow
        following_id = params[:follow_id]
        if Follower.create(follower_id: current_api_v1_user.id, following_id: following_id)
          render status: :ok
        else
          render status: :unprocessable_entity
        end
      end
    end
  end
end
