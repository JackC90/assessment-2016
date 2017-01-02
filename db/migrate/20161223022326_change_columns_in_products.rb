class ChangeColumnsInProducts < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :discount, :integer, default: 0
  	change_column :products, :language, "integer USING CAST(language AS integer)", default: 0
  end
end
