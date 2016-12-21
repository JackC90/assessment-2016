class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :description
      t.boolean :whatsapp
      t.string :phone
      t.date :birthdate
      t.text :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
