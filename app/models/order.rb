# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  name          :string
#  tel           :string
#  zipcode       :string
#  address       :string
#  delivery_day  :date
#  delivery_time :string
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#

class Order < ActiveRecord::Base
  ADDITIONAL_NUM = 5
  ADDITIONAL_AMOUNT = 600
  BUSINESS_DAY_FROM = 3
  BUSINESS_DAY_TO = 14

  extend Enumerize

  enumerize :delivery_time, in: [:t8_12, :t12_14, :t14_16, :t16_18, :t18_20, :t20_21]

  attr_reader :min_day, :max_day
  delegate :items, to: :cart, allow_nil: true

  validates :name, presence: true, length: { minimum: 4, maximum: 20 }
  validates :tel, presence: true, length: { minimum: 10, maximum: 13 }
  validates :zipcode, presence: true, length: { minimum: 7, maximum: 8 }
  validates :address, presence: true, length: { minimum: 10, maximum: 100 }
  validates :delivery_day, presence: true
  validate :delivery_day_limit, unless: 'delivery_day.blank?'
  validates :delivery_time, presence: true

  belongs_to :user
  has_one :cart

  after_create :set_order_info_to_cart
  after_create :set_default_address, if: -> { user.default_address.name.blank? }
  after_initialize :initialize_business_days

  def postage_amount
    ((1.0 * items.to_a.sum(&:quantity)) / ADDITIONAL_NUM).ceil * ADDITIONAL_AMOUNT
  end

  def fee_amount
    case cart.total_amount
    when 100_000..Float::INFINITY
      1_000
    when 30_000..100_000
      600
    when 10_000..30_000
      400
    else
      300
    end
  end

  def tax_amount
    (cart.total_amount + postage_amount + fee_amount) * Settings.excise_percent / 100
  end

  def total_amount
    cart.total_amount + postage_amount + fee_amount + tax_amount
  end

  private
    def set_order_info_to_cart
      cart.try :update, checkouted: true
    end

    def set_default_address
      user.default_address.copy_from self
      user.default_address.save!
    end

    def initialize_business_days
      @min_day = BUSINESS_DAY_FROM.business_days.from_now.to_date
      @max_day = BUSINESS_DAY_TO.business_days.from_now.to_date
    end

    def delivery_day_limit
      unless delivery_day.between?(min_day, max_day) && delivery_day.workday?
        errors.add(
          :delivery_day,
          I18n.t(
            'activerecord.errors.messages.invalid_business_day',
            from: BUSINESS_DAY_FROM,
            to: BUSINESS_DAY_TO
          )
        )
      end
    end
end
