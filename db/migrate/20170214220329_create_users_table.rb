class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :email
  		t.string :password
  		t.text :description
  		t.string :pic
  		t.timestamps
  	end
  end
end
