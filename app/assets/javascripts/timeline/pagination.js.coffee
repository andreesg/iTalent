
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

$ ->
  if $('#publication-infinite-scrolling').size() > 0
    $(window).bindWithDelay 'scroll', ->
      more_posts_url = $('.pagination .next_page a').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
          $.getScript more_posts_url, ->
            pushPage(more_posts_url.match(page_regexp)[0])
      return
      return
    , 100

page_regexp = /\d+$/
 
pushPage = (page) ->
    #History.pushState null, "InfiniteScrolling | Page " + page, "?page=" + page
    return

hash = window.location.hash
if hash.match(/page=\d+/i)
  window.location.hash = '' # Otherwise the hash will remain after the page reload
  window.location.search = '?page=' + hash.match(/page=(\d+)/i)[1]
