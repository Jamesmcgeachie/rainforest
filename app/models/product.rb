class Product < ActiveRecord::Base

	validates :description, :name, presence: true
	validates :price_in_cents, numericality: {only_integer: true}

	has_many :reviews

	def cents_to_dollars
		price_in_dollars = price_in_cents.to_f / 100
		sprintf("%.2f", price_in_dollars)
	end

end
