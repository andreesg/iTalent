
$(document).ready ->
  $("#new-publication-btn").click ->
    showPublicationModal()
  $("#new-event-btn").click ->
    showEventModal()

showPublicationModal = () ->
  $('#new-publication-modal').modal('show')

showEventModal = () -> 
  $('#new-event-modal').modal('show')

$(document).ready ->
  $("div.load-comments > a").click ->
    publication_id = $(@).data("publication-id")
    comment_id = $("#publication-"+publication_id+"-comments").children().first().data("comment-id")
    $.ajax({
      type: "POST",
      url: "/publications/"+publication_id+"/comments/load",
      data: { last_comment_id: comment_id },
      success:(data) ->
        return true
      error:(data) ->
        return false
    })

