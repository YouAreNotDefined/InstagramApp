module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def show
      end

      def create
        @comment = current_api_v1_user.comments.new(comment_params)

        if @comment.save
          render status: :created
        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        comment = current_api_v1_user.comments.find(params[:id])
        comment.destroy
      end

      private

      def comment_params
        params.require(:post).permit(:comment, :post_id)
      end
    end
  end
end
