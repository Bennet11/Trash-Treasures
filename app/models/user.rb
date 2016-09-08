class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauth_providers => [:facebook]

  acts_as_messageable
  has_many :posts, dependent: :destroy
  has_many :watchlists, dependent: :destroy
  has_many :profiles
  has_many :categorized_posts, through: :category, source: :post

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def watchlist_for(post)
    watchlists.where(post_id: post.id).first
  end

  def watchlisted_posts
    # watchlists.includes(:post).map(&:post)
    Post.where(id: watchlists.pluck(:id))
  end

  def self.from_omniauth(auth)
    u = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.username
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end

    u.update(
      name: auth.info.name,
      image: auth.info.image.gsub('http://','https://')
    )
    u
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end

  def handle
    self.name || self.email
  end
end
