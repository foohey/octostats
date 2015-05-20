$(document).on "ready page:load", ->
  if dates = $('[data-ago]')
    now = moment()
    dates.each (index, date) ->
      time = moment($(date).data("ago"))
      $(date).html(time.from(now))
