class AddPostageToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :postage, :integer
  end
end
