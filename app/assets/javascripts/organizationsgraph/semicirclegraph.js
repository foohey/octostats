function drawChart(arrayOrganizations)
{
    $(function () {
        $('#graphs').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: 0,
                plotShadow: false
            },
            title: {
                text: 'Organizations<br>members',
                align: 'center',
                verticalAlign: 'middle',
                y: 50
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}</b>'
            },
            plotOptions: {
                pie: {
                    dataLabels: {
                        enabled: true,
                        distance: -50,
                        style: {
                            fontWeight: 'bold',
                            color: 'white',
                            textShadow: '0px 1px 2px black'
                        }
                    },
                    startAngle: -90,
                    endAngle: 90,
                    center: ['50%', '75%']
                }
            },
            series: [{
                type: 'pie',
                name: 'Number of members',
                innerSize: '50%',
                data: arrayOrganizations
            }]
        });
    });

}

function ajaxGetOrganizationsData() {

    var organizations = [];
    $.ajax({

        url: '/organizations',
        type: 'GET',
        dataType: 'json',
        success: function(data, statut){
            drawChart(data)
        }

    });
}

$(document).on('ready page:load', function () {
  if ( $("#graphs").length ) {
    ajaxGetOrganizationsData();
  }
})