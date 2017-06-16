class CreateActivityBases < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_bases do |t|
      t.string :title
      t.date :begin_time
      t.date :end_time
      t.string :desc

      t.timestamps
    end
  end
end
