class ChangeSellTypeIdReference < ActiveRecord::Migration[5.1]
  def change
		remove_reference :real_estate_sell_type_links, :sell_type
		add_reference :real_estate_sell_type_links, :real_estate_sell_type, foreign_key: true
  end
end
