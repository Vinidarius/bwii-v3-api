class AddAttibutesToSellTypeLinks < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estate_sell_type_links, :price, :integer
		add_column :real_estate_sell_type_links, :honoraire, :integer
		add_column :real_estate_sell_type_links, :global_price, :integer
  end
end
