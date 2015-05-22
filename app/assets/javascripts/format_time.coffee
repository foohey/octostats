$(document).on "ready page:load", ->
  if dates = $('[data-ago]')
    now = moment()
    dates.each (index, date) ->
      time = moment($(date).data("ago"))
      $(date).html(time.from(now))

  if dates = $('[data-header]') 
    now = moment()
    dates.each (index, date) ->
      time = moment($(date).data("header"))
      $(date).html(time.format('ll'))