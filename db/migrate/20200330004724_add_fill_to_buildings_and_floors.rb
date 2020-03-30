class AddFillToBuildingsAndFloors < ActiveRecord::Migration[5.1]
  def change
		add_column :buildings, :fill, :integer
		add_column :floors, :fill, :integer
  end
end
