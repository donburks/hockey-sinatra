class CreateSlug < ActiveRecord::Migration
	def change
		change_table :teams do |t|
			t.string :slug
		end
	end
end
