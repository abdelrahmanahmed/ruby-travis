class User < ApplicationRecord
	has_and_belongs_to_many :orders
	#has_and_belongs_to_many :groups
	has_many :order
    has_many :groups, dependent: :destroy
    has_many :group_users, dependent: :destroy
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

	def self.search(search)
		where(" users.email LIKE ?", "%#{search}%")
	end
	def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      # user.image.url = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end      
  	end

def generate_password_token!
  self.reset_password_token = generate_token
  self.reset_password_sent_at = Time.now.utc
  save!
end

def password_token_valid?
  (self.reset_password_sent_at + 4.hours) > Time.now.utc
end

def reset_password!(password)
  self.reset_password_token = nil
  self.password = password
  save!
end

private

def generate_token
  SecureRandom.hex(10)
end

   
end
