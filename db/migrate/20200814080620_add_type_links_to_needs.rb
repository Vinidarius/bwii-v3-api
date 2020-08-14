class AddTypeLinksToNeeds < ActiveRecord::Migration[5.1]
  def change
		add_reference :real_estate_sell_type_links, :need, foreign_key: true
  end
end
