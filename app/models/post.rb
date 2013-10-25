class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  belongs_to :contact
  belongs_to :contact_type
  has_many :comments

  scope :john, lambda{where(user_id:4).order('created_at DESC')}
  scope :wayne, lambda{where(user_id:5).order('created_at DESC')}
  scope :not_complete, lambda{where(complete:false).order('created_at DESC')}



  def self.search(search)
  	if search
  		# find(:all, :joins => :contact, :conditions => ['posts.title LIKE ? or posts.body LIKE ? or contacts.first_name LIKE ? or contacts.last_name LIKE ? or contacts.company LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%" , "%#{search}%", "%#{search}%"])
  		joins(:contact, :user).where(['LOWER(posts.title) LIKE ? or LOWER(posts.body) LIKE ? or LOWER(contacts.first_name) LIKE ? or LOWER(contacts.last_name) LIKE ? or LOWER(contacts.company) LIKE ? or LOWER(users.display_name) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%" , "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%"]).order('created_at DESC')
  	else
  		where.order('created_at DESC')
  	end
  end
end
