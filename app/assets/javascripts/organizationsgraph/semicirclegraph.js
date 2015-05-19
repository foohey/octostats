$(document).on('ready page:load', function () {
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: 0,
            plotShadow: false
        },
        title: {
            text: 'Liste<br>des organisations',
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
            name: 'Nombre de membres',
            innerSize: '50%',
            data: [
                ['Organization1',   47],
                ['Orga2',       26],
                ['MyOrga', 12],
                ['OrgaKiRox',    8],
                ['LadyOrgaga',     6],
                {
                    name: 'Others',
                    y: 1,
                    dataLabels: {
                        enabled: false
                    }
                }
            ]
        }]
    });
});