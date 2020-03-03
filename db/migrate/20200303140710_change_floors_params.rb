class ChangeFloorsParams < ActiveRecord::Migration[5.1]
  def change
		add_column :rooms, :name, :string

		add_reference :floors, :building, foreign_key: true
		remove_column :floors, :real_estate_id
  end
end
