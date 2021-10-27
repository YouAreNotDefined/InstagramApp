class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_create :set_active

  scope :active, -> { where(:active => true)}

  private

  def set_active
    self.active = true
  end

end
