class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :nick_name
      t.string :avatar

      t.timestamps null: false
    end

    remove_column :users, :nick_name
  end
end
