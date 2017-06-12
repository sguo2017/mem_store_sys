class AddBonusChangeIdToScoreQueries < ActiveRecord::Migration[5.1]
  def change
    add_column :score_histories, :bonus_change_id, :string
  end
end
