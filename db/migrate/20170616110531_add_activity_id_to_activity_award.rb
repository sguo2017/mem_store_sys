class AddActivityIdToActivityAward < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_awards, :activity_id, :integer
  end
end
