class AddStatusToActivityAward < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_awards, :status, :string, :default => '00A'
  end
end
