class AddColumnPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :commentable, :boolean, default: true, null: false
  end
end
