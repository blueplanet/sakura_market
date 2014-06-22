class DefaultAddress < ActiveRecord::Base
  belongs_to :user

  ATTRS = %w(name tel zipcode address)

  validates :name, presence: true, length: {minimum: 4, maximum: 20}
  validates :tel, presence: true, length: {minimum: 10, maximum: 13}
  validates :zipcode, presence: true, length: {minimum: 7, maximum: 8}
  validates :address, presence: true, length: {minimum: 10, maximum: 100}

  def copy_from from
    ATTRS.each do |attr|
      self[attr] = from[attr]
    end
  end
end
