class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  with_options presence: true do
    validates :comment
    validates :user_id
    validates :post_id
  end

  after_create :increase_post_comment_like
  after_destroy :decrease_post_comment_like

  private

  def increase_post_comment_like
    Post.find(self.post_id).increment(:total_comments_count).save
  end

  def decrease_post_comment_like
    Post.find(self.post_id).decrement(:total_comments_count).save
  end
end
