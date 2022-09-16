class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  PERMIT_ATTR = %i(content image).freeze

  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_length_content}
  validates :image, content_type: {in: Settings.micropost.image_path,
                                   message: I18n.t(".wrong_format")},
                    size: {less_than: Settings.micropost.max_data.megabytes,
                           message: I18n.t(".size_warning")}

  delegate :name, to: :user, prefix: true
  scope :recent, ->{order created_at: :desc}
  scope :search_by_id, ->(user_ids){where user_id: user_ids}

  def display_image
    image.variant(resize_to_limit: Settings.micropost.max_size)
  end
end
