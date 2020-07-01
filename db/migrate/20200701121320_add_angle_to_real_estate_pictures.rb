class AddAngleToRealEstatePictures < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estate_pictures, :angle, :integer, default: 0
  end
end
