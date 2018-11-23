$(document).on 'turbolinks:load', ->
  $('#prototype-tags').tagit
    fieldName: 'tag_list',
    singleField: true,
    tagLimit: 3
  $('#prototype-tags').tagit()
  tag_string = $("#tag_hidden").val()
  try
    tag_list = tag_string.split(',')
    for tag in tag_list
      $('#prototype-tags').tagit 'createTag', tag
  catch error
