class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :watchlists, dependent: :destroy
  has_attached_file :image,
    styles: { large: "1000x900", medium: "500x500", thumb: "100x100#"},
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  delegate :name, to: :category, prefix: true

  def owner
    user
  end

  def sold
    self.update(paid: true)
  end
end
