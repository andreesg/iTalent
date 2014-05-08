
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
  	