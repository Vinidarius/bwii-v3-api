class AddDispoAreaToRealEstates < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estates, :dispo_area, :integer
  end
end
