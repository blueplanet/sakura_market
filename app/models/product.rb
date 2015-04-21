# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :string
#  price       :integer
#  description :text
#  display_no  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
