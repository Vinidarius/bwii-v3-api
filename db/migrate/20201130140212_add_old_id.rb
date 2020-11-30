class AddOldId < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estates, :old_id, :integer
		add_column :users, :old_id, :integer
  end
end
