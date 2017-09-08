class AddCityToScoreHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :score_histories, :city, :string
  end
end
