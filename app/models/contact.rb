class Contact < ActiveRecord::Base
	cattr_accessor :login_user
	belongs_to :user
	has_many :posts

	scope :john, lambda{where(user_id:4).order('last_name')}
	scope :wayne, lambda{where(user_id:5).order('last_name')}
	
	extend FriendlyId
	friendly_id :full_name, use: :slugged

	def full_name
	  "#{first_name}-#{last_name}"  
	end

	def avatar
		if self.email
			Gravatar.new(self.email).image_url
		else
			Gravatar.new("generic@example.com").image_url
		end
	end

	def self.search(search)
		if search
			where(['LOWER(first_name) LIKE ? or LOWER(last_name) LIKE ? or LOWER(company) LIKE ?', "%#{search.downcase}%","%#{search.downcase}%","%#{search.downcase}%"]).order('last_name')
		else
			order('last_name')
		end
	end

	def self.to_csv(options ={})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |contact|
				csv << contact.attributes.values_at(*column_names)
			end
		end
	end

	# def self.import(file)	
	# 	CSV.foreach(file.path, headers: true) do |row|
	# 		Contact.create! row.to_hash	
	# 	end
	# end

	def self.import(file)
		allowed_attributes = ['id', 'first_name', 'middle_name', 'last_name', 'suffix', 'company', 'department', 'job_title', 'business_street', 'business_city', 'business_state', 'business_zipcode', 'business_fax', 'business_phone', 'business_phone2', 'company_phone', 'home_phone', 'mobile_phone', 'other_phone', 'email', 'website']	
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			contact = find_by_id(row["id"]) || new
			contact.attributes = row.to_hash.select{ |k,v| allowed_attributes.include? k}
			contact.user_id = self.login_user.id
			contact.save!
		end	
	end

	def self.open_spreadsheet(file)
		 # Rails.logger.debug("My file: #{file.path}")
		case File.extname(file.original_filename)
			# when ".csv" then Roo::CSV.new(file.path)
			# when ".xls" then Roo::Excel.new(file.path)
			# when ".xlsx" then Roo::Excelx.new(file.path)
			# else raise "Unknown file type: #{file.original_filename}"
			when ".csv" then Roo::Csv.new(file.path)
			when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
			when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
			else raise "Unknown file type: #{file.original_filename}"
		end
	end
	# def self.import(file)	
	# 	allowed_attributes = ['id', 'first_name', 'middle_name', 'last_name', 'suffix', 'company', 'department', 'job_title', 'business_street', 'business_city', 'business_state', 'business_zipcode', 'business_fax', 'business_phone', 'business_phone2', 'company_phone', 'home_phone', 'mobile_phone', 'other_phone', 'email', 'website']
	# 	CSV.foreach(file.path, headers: true) do |row|
	# 		contact = where(:id, row["id"]) || new
	# 		# contact.attributes = row.to_hash.slice(*['first_name', 'middle_name', 'last_name', 'suffix', 'company', 'department', 'job_title', 'business_street', 'business_city', 'business_state', 'business_zipcode', 'business_fax', 'business_phone', 'business_phone2', 'company_phone', 'home_phone', 'mobile_phone', 'other_phone', 'email', 'website'])
	# 		contact.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
	# 		contact.save!
	# 	end
	# end
end
