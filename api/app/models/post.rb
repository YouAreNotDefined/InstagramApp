class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :place, optional: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags

  validates :commentable, inclusion: { in: [true, false] }
  with_options presence: true do
    validates :image
    validates :description
    validates :user_id
  end

  before_create ->{
    set_active
    set_count
  }

  scope :active, -> { where(:active => true)}

  def extract_hashtags
    return if description.blank?

    description.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
  end

  private

  def set_active
    self.active = true
  end

  def set_count
    self.total_likes_count ||= 0
    self.total_comments_count ||= 0
  end
end
