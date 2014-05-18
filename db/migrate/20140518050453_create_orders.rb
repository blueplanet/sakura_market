class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :tel
      t.string :region
      t.string :city
      t.string :zipcode
      t.string :address
      t.date :delivery_day
      t.integer :delivery_time

      t.timestamps
    end
  end
end
