class AddOldIdToNeeds < ActiveRecord::Migration[5.1]
  def change
		add_column :needs, :old_id, :integer
  end
end
