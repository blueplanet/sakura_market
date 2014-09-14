$ ->
  $('a.good').on 'ajax:success', ->
    $(@).addClass('disabled')
