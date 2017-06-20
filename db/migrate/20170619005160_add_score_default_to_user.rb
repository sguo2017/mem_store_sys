class AddScoreDefaultToUser < ActiveRecord::Migration[5.1]
  def change
     change_column :users, :score, :integer, :default => 0
     change_column :users, :score_total, :integer, :default => 0
  end
end
