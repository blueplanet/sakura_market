class OrdersNew

  constructor: ->
    @setupDatePicker()

  setupDatePicker: ->
    $date_picker = $('#order_delivery_day')
    minDays = $date_picker.data('mindays')
    maxDays = $date_picker.data('maxdays')

    $date_picker.datepicker minDate: minDays, maxDate: maxDays

$ ->
  if $('body#orders-new').length
    new OrdersNew()
