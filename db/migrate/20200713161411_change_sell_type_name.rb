class ChangeSellTypeName < ActiveRecord::Migration[5.1]
  def change
		rename_table :sell_types, :real_estate_sell_types
  end
end
