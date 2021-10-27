class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.references :follower , foreign_key: { to_table: :users }
      t.references :following , foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
