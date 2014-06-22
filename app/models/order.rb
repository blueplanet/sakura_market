class Order < ActiveRecord::Base
  ADDITIONAL_NUM = 5.freeze
  ADDITIONAL_AMOUNT = 600.freeze

  extend Enumerize

  enumerize :delivery_time, in: [:t8_12, :t12_14, :t14_16, :t16_18, :t18_20, :t20_21]

  attr_reader :min_day, :max_day

  validates :name, presence: true
  validates :tel, presence: true
  validates :zipcode, presence: true
  validates :address, presence: true
  validates :delivery_day, presence: true
  validate :delivery_day_limit
  validates :delivery_time, presence: true

  belongs_to :user
  def initialize
    super

    @min_day = business_days_after(3)
    @max_day = business_days_after(14)
  end

  def postage(items)
    ((1.0 * items.to_a.sum(&:quantity)) / ADDITIONAL_NUM).ceil * ADDITIONAL_AMOUNT
  end

  def fee(items)
    origin_fee = case items.to_a.sum { |item| item.product.price * item.quantity }
      when "> 100_000"
        10_000
      when "> 30_000"
        600
      when "> 10_000"
        400
      else
        300
      end

    (100.0 + Settings.excise_percent) / 100 * origin_fee
  end

  private
    def business_days_after num
      date = Date.today

      while num > 0
        date += 1
        num -= 1 if 1 <= date.wday and date.wday <= 5
      end

      date
    end

    def delivery_day_limit
      errors.add(:delivery_day, 'over range of days') if delivery_day < min_day or delivery_day > max_day
    end
end
