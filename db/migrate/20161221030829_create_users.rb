class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string 	:username
      t.string 	:email # uniqueness
      t.text 	:encrypted_password
      t.string 	:salt
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
