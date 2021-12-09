class ChangeColumnsDefaultOnPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :total_likes_count, from: nil, to: 0
    change_column_default :posts, :total_comments_count, from: nil, to: 0
  end
end
