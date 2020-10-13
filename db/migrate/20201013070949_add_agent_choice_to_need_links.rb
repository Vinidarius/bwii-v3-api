class AddAgentChoiceToNeedLinks < ActiveRecord::Migration[5.1]
  def change
		add_column :need_links, :agent_choice, :boolean, default: false
  end
end
