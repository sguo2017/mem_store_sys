class CreateManagestoresAdminsJoinTable < ActiveRecord::Migration[5.1]
  def change
      create_table :managestores_admins, id: false do |t|
      t.integer :managestore_id
      t.integer :admin_id
    end
 
    add_index :managestores_admins, :managestore_id
    add_index :managestores_admins, :admin_id
  end
end
