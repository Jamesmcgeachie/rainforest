class User < ActiveRecord::Base

	validates :password, length: { in: 4..20 }
	validates :name, :email, presence: true
	validates :email, uniqueness: true
	has_secure_password
	has_many :reviews
	before_save :capitalize_name

	private
	def capitalize_name
		self.name = name.titleize
	end
end
