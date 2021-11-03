class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :place, optional: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags
  accepts_nested_attributes_for :post_hashtags

  before_create :set_active

  scope :active, -> { where(:active => true)}

  private

  def set_active
    self.active = true
  end
end
