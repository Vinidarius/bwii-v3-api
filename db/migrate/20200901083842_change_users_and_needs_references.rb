class ChangeUsersAndNeedsReferences < ActiveRecord::Migration[5.1]
  def change
		add_reference :need_links, :user, foreign_key: true

		remove_reference :needs, :user
  end
end
