module OrdersHelper
  def business_days_after(num)
    date = Date.today

    while num > 0
      date += 1
      num -= 1 if 1 <= date.wday and date.wday <= 5
    end

    (date - Date.today).to_i
  end
end
