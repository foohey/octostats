$(document).on 'ready page:load', ->

  #$('#commits_graph').on 'click', (e) ->
  # e.preventDefault()
  #  console.log "po"

  if $('#commitsGraph').length
    $.ajax
      url: "#{window.location.pathname}/commits"
      type: 'GET'
      dataType: 'json'
      success: (datas, statut) ->
        # format datas (mon - sun) to (sun - sat)
        datas.unshift datas.pop()
        $ ->
          $('#graphs').highcharts
            chart: type: 'line'
            title: text: 'Git Commits'
            subtitle: text: ''
            xAxis: categories: [
              'Sunday'
              'Monday'
              'Tuesday'
              'Wednesday'
              'Thursday'
              'Friday'
              'Saturday'
            ]
            yAxis: title: text: 'Number of Commits'
            plotOptions: line:
              dataLabels: enabled: true
              enableMouseTracking: true
            series: [ {
              name: 'Commits'
              data: datas
            } ]
          return