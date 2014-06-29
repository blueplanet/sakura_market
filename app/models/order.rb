class Order < ActiveRecord::Base
  ADDITIONAL_NUM = 5.freeze
  ADDITIONAL_AMOUNT = 600.freeze
  BUSINESS_DAY_FROM = 3.freeze
  BUSINESS_DAY_TO = 14.freeze

  extend Enumerize

  enumerize :delivery_time, in: [:t8_12, :t12_14, :t14_16, :t16_18, :t18_20, :t20_21]

  delegate :items, to: :cart

  attr_reader :min_day, :max_day

  validates :name, presence: true
  validates :tel, presence: true
  validates :zipcode, presence: true
  validates :address, presence: true
  validate :delivery_day_limit
  validates :delivery_time, presence: true

  belongs_to :user
  has_one :cart

  after_create :set_default_address, if: -> { user.default_address.blank? }
  def set_default_address
    default = DefaultAddress.new user: user
    default.copy_from self

    default.save!
  end

  after_initialize :initialize_business_days
  def initialize_business_days
    @min_day = business_days_after(BUSINESS_DAY_FROM)
    @max_day = business_days_after(BUSINESS_DAY_TO)
  end

  def postage_amount
    ((1.0 * items.to_a.sum(&:quantity)) / ADDITIONAL_NUM).ceil * ADDITIONAL_AMOUNT
  end

  def fee_amount
    case cart.total_amount
    when "> 100_000"
      1_000
    when "> 30_000"
      600
    when "> 10_000"
      400
    else
      300
    end
  end

  def tax_amount
    (cart.total_amount + postage_amount + fee_amount) * Settings.excise_percent / 100
  end

  def total
    cart.total_amount + postage_amount + fee_amount + tax_amount
  end

  private
    def business_days_after num
      date = Date.today

      while num > 1
        date += 1
        num -= 1 if 1 <= date.wday and date.wday <= 5
      end

      date
    end

    def delivery_day_limit
      errors.add :delivery_day, :blank and return if delivery_day.blank?
      if delivery_day < min_day or delivery_day > max_day or [0, 6].include?(delivery_day.wday) 
        errors.add(:delivery_day, 
          I18n.t('activerecord.errors.messages.invalid_business_day', 
            from: BUSINESS_DAY_FROM, to: BUSINESS_DAY_TO)) 
      end
    end
end
