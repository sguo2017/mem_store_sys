class CreateScoreHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :score_histories do |t|
      t.integer :point
      t.string :object_type
      t.string :object_id
      t.string :oper
      t.integer :user_id

      t.timestamps
    end
  end
end
