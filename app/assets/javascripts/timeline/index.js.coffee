
$(document).ready ->
	$("#new-publication-btn").click ->
		showPublicationModal()
	$("#new-event-btn").click ->
		showEventModal()

showPublicationModal = () ->
 	$('#new-publication-modal').modal('show')

showEventModal = () -> 
	$('#new-event-modal').modal('show')