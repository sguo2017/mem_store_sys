class AddIndexOfToActivityAward < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_awards, :index_of, :integer
  end
end
