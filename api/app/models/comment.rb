class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates_presence_of :comment
  validates_presence_of :user_id
  validates_presence_of :post_id

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