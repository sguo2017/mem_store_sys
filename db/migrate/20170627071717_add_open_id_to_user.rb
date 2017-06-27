class AddOpenIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :openid, :string
    add_column :users, :nickname, :string
    add_column :users, :language, :string
    add_column :users, :headimgurl, :string
  end
end
