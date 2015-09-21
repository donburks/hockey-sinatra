class Team < ActiveRecord::Base
	has_many :players
	validates :city, presence: true
	validates :name, presence: true

	after_create :set_slug

	def set_slug
		self.slug = gen_slug
		self.save
	end

	private
		def gen_slug
			"#{city.downcase}-#{name.downcase}"
		end
end
