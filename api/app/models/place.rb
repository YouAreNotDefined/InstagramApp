class Place < ApplicationRecord
  has_many :posts

  with_options presence :true do
    validates :name
    validates :lat
    validates :lon
  end
end
