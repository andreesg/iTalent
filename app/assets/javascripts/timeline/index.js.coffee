
$(document).ready ->
  $("#new-publication-btn").click ->
    showPublicationModal()
  $("#new-event-btn").click ->
    showEventModal()

showPublicationModal = () ->
  $('#new-publication-modal').modal('show')

showEventModal = () -> 
  $('#new-event-modal').modal('show')

$(document).on "page:change", ->
  $("a[data-publication-id data-comment-id]").click ->
    publication_id = $(this).data("publication-id")
    comment_id = $(this).data("comment-id")

###
$(document).ready ->
  if $('body.timeline').length
    updatePublications = (publications) ->
      alert "cena"

    gon.watch('publications', interval: 10000000000000, updatePublications)



$('#stop-renewing').click ->
 gon.unwatch('users_count', updateComments)
 return false
###
