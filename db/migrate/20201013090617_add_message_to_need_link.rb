class AddMessageToNeedLink < ActiveRecord::Migration[5.1]
  def change
		add_column :need_links, :body, :string
  end
end
