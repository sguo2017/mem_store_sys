class AddScoreTotalToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :score_total, :integer
  end
end
