class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.text :description
      t.integer :display_no

      t.timestamps
    end
  end
end
