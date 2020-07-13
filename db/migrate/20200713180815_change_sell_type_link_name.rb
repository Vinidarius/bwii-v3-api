class ChangeSellTypeLinkName < ActiveRecord::Migration[5.1]
  def change
		rename_table :sell_type_links, :real_estate_sell_type_links
  end
end
