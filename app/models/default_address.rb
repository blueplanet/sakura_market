# == Schema Information
#
# Table name: default_addresses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  tel        :string
#  zipcode    :string
#  address    :string
#  created_at :datetime
#  updated_at :datetime
#

class DefaultAddress < ActiveRecord::Base
  belongs_to :user

  ATTRS = %w(name tel zipcode address)

  with_options on: :update do
    validates :name, presence: true, length: { minimum: 4, maximum: 20 }
    validates :tel, presence: true, length: { minimum: 10, maximum: 13 }
    validates :zipcode, presence: true, length: { minimum: 7, maximum: 8 }
    validates :address, presence: true, length: { minimum: 10, maximum: 100 }
  end

  def copy_from!(from)
    ATTRS.each do |attr|
      self[attr] = from[attr]
    end

    save!
  end

  def copy_to(to)
    ATTRS.each do |attr|
      to[attr] = self[attr]
    end
  end
end
