class Image < ActiveRecord::Base
  has_attached_file :image, styles: { large: "1000x900", medium: "500x500", thumb: "200x200#", avatar: "50x50#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
end
