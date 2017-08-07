class ChangeLatLntToFloatStore < ActiveRecord::Migration[5.1]
  def change
	change_column :stores, :longitude, :float
	change_column :stores, :latitude, :float
  end
end
