class CreateApiV1Genders < ActiveRecord::Migration[5.2]
  def change
    create_table :genders do |t|
      t.integer :type
      t.string :detail

      t.timestamps
    end
  end
end
