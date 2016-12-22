class CreateCheckouts < ActiveRecord::Migration[5.0]
  def change
    create_table :checkouts do |t|
      t.decimal :amount
      t.text :token
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
