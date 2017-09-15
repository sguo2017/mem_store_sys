class Store < ApplicationRecord
	has_and_belongs_to_many :users
	has_and_belongs_to_many :admins, 
	    class_name: "User", 
	    foreign_key: "managestore_id", 
	    association_foreign_key: "admin_id",
	    join_table: "managestores_admins"
end
