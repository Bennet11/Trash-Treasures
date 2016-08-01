class Post < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: { large: "1000x900", medium: "500x500", thumb: "200x200#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
