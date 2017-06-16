class AddAwardCountToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :award_count, :integer
  end
end
