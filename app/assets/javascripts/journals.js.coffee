$ ->
  $('a.good').on 'ajax:success', ->
    $(@).removeClass('btn-success').addClass('btn-default disabled')
