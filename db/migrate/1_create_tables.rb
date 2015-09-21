class CreateTables < ActiveRecord::Migration
	def change
		create_table :teams do |t|
			t.string :city
			t.string :name
			t.string :mascot
			t.timestamps
		end

		create_table :players do |t|
			t.string :first_name
			t.string :last_name
			t.references :team
			t.integer :number
		end
	end
end
