class Product < ActiveRecord::Base
  belongs_to :category
  delegate :name, to: :category, prefix: true
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, :category_id, presence: true
end
