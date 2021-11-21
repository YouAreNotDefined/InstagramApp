module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_api_v1_user!
      after_action :post_likes

      def create
        post_id = params[:post_id]
        exist_like = current_api_v1_user.likes.where(post_id: post_id)

        if exist_like.any?
          exist_like.first.destroy
          return render status: :ok
        end

        @like = current_api_v1_user.likes.new(post_id: post_id)

        if @like.save
          render status: :ok
        else
          render status: :unprocessable_entity
        end
      end

      private

      def post_likes
        @post_likes = Post.find(post_id).total_likes_count
      end

    end
  end
end
