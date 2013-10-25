class User < ActiveRecord::Base
  rolify

  extend FriendlyId
  friendly_id :display_name, use: :slugged

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Removed :registerable ,:recoverable,
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_many :posts       
  has_many :contacts

  def avatar
		Gravatar.new(self.email).image_url
	end

	def admin?
		has_role?(:admin)
	end

end
