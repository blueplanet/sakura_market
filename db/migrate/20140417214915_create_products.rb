class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.string :price
      t.text :describe
      t.integer :display_no

      t.timestamps
    end
  end
end
