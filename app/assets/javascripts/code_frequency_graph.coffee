$(document).on 'ready page:load', ->

  if $('#codeFrequencyGraph').length
    $ ->
      $('#codeFrequencyGraph').highcharts
        chart: type: 'area'
        title: text: 'Area chart with negative values'
        xAxis: 
          type: 'datetime',
          tickInterval:24 * 3600 * 1000 * 24,
        credits: enabled: false
        series: [
          {
            name: 'Additions',
            pointInterval: 24 * 3600 * 1000 * 24,
            pointStart: Date.UTC(2015, 2, 1),
            data: [
              0
              14
              3
              0
              2
            ]
          }
          {
            name: 'Deletions',
            pointInterval: 24 * 3600 * 1000 * 24,
            pointStart: Date.UTC(2015, 2, 1),
            data: [
              0
              -12
              -4
              -2
              -1
            ]
          }
        ]
      return