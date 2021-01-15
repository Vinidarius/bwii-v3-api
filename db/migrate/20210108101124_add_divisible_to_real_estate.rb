class AddDivisibleToRealEstate < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estates, :divisible, :integer
  end
end
