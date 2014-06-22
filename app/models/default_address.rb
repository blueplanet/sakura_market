class DefaultAddress < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: {minimum: 4, maximum: 20}
  validates :tel, presence: true, length: {minimum: 10, maximum: 13}
  validates :zipcode, presence: true, length: {minimum: 7, maximum: 8}
  validates :address, presence: true, length: {minimum: 10, maximum: 100}
end
