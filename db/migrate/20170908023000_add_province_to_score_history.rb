class AddProvinceToScoreHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :score_histories, :province, :string
  end
end
