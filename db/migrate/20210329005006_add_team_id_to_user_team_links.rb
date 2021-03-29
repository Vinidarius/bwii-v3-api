class AddTeamIdToUserTeamLinks < ActiveRecord::Migration[5.1]
  def change
		add_column :user_team_links, :team_id, :integer
  end
end
