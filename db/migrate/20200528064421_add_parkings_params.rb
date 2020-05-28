class AddParkingsParams < ActiveRecord::Migration[5.1]
  def change
		add_column :parkings, :nature, :boolean, default: false
		add_column :parkings, :price, :integer
		add_column :parkings, :sell_method, :integer
  end
end
