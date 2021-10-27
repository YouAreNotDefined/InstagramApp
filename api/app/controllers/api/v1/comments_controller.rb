class CommentsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def comment_params
    params.require(:post).permit(:comment, :post_id)
  end
end
