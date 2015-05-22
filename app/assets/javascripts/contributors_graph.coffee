$(document).on 'ready page:load', ->
  if $('#contributors').length
    $.ajax
      url:      window.location.pathname
      type:     'GET'
      dataType: 'json'
      success: ( datas, statut ) ->
        series = datas.map ( s ) ->
          name: s.login
          data: s.commits.map (c) -> c.count

        char = $("#contributors").highcharts
          chart: type: 'area'
          title: text: 'All time contributions'
          tooltip: pointFormat: '{series.name} commits <b>{point.y:,.0f}</b>'
          plotOptions: area:
            pointStart: Date.parse( moment( datas[0].commits[0].commit_at ).format('YYYY-MM-DD') )
            pointInterval: 24 * 3600 * 1000
            marker:
              enabled: false
              symbol: 'circle'
              radius: 2
              states: hover: enabled: true
          xAxis:
            allowDecimals: false
            type: 'datetime'
            dateTimeLabelFormat:
              day: '%e.%b'
          yAxis:
            title: text: 'Number of contributions'
          series: series
