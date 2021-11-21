module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_post, only: [:show]

      def show
        @comments = Comment.includes(:user).where(post_id: @post.id)
      end

      def create
        @post = current_api_v1_user.posts.new(post_params)

        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        post = current_api_v1_user.posts.find(params[:id])
        post.destroy
      end

      private

      def set_post
        @post = current_api_v1_user.posts.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:description, :place_id, :commentable, :image)
      end
    end
  end
end
