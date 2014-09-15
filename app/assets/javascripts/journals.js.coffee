$ ->
  $('a.good').on 'ajax:success', ->
    $(@).removeClass('btn-success').addClass('btn-default disabled')

  $('input.journal-image-field').on 'change', ->
    $preview = $(@).closest('form').find('.journal-image')
    [file] = $(@).get(0).files
    fr = new FileReader()
    fr.readAsDataURL(file)
    fr.onload = (event) ->
      $preview.attr src: event.target.result
      $preview.removeClass('hide')

  $('#commentModal').on 'hide.bs.modal', ->
    $('#commentModal').find('form')[0].reset()
