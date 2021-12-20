class Gender < ApplicationRecord
  self.inheritance_column = :_type_disabled

  has_many :users

  enum type: { male: 1, female: 2, customize: 3, no_answer: 4 }, _prefix: true
end
