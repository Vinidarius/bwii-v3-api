class AddMultipleToActors < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estate_actors, :multiple, :boolean, default: false
  end
end
