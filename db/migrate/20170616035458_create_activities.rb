class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :title
      t.date :begin_time
      t.date :end_time
      t.string :desc
      t.string :avatar

      t.timestamps
    end
  end
end
