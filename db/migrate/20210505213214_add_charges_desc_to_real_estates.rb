class AddChargesDescToRealEstates < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estates, :charges_desc, :string
  end
end
