class AddImageToJournals < ActiveRecord::Migration
  def change
    add_column :journals, :image, :string
  end
end
