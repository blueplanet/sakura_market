class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.belongs_to :journal, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
