class AddUsersColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :gender_id, false, 4
    change_column_default :users, :gender_id, from: nil, to: 4
  end
end
