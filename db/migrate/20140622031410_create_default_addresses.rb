class CreateDefaultAddresses < ActiveRecord::Migration
  def change
    create_table :default_addresses do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :tel
      t.string :zipcode
      t.string :address

      t.timestamps
    end
  end
end
