class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.decimal :price
      t.integer :category
      t.integer :sale_or_rent
      t.text :description
      t.string :ages
      t.integer :format
      t.integer :pages
      t.date :publication_date
      t.string :publisher
      t.string :publication_city
      t.string :language
      t.string :isbn
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
