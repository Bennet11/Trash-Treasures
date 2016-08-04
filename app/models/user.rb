class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauth_providers => [:facebook]

  acts_as_messageable

  has_many :posts, dependent: :destroy

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
      image: auth.info.image
    )
    u
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end
end
