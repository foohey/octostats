function formatArray(array)
{
    newArray = []
    $.each(array,function(key, value) {
        var anotherArray = $.map(value, function(newValue, index) {
           return [newValue];
        });
        newArray.push(anotherArray);
    });
    return newArray;
}

function drawChart(arrayOrganizations)
{   
    $(function () {
        $('#container').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: 0,
                plotShadow: false
            },
            title: {
                text: 'Organizations<br>List',
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

            for (var i = 0; i < data.length; i++) {

                var login = data[i].login;
                //organizations[data[i].login] = 0;
                var obj = {};
                $.ajax({
                    url: '/organizations/' + data[i].login + '/members',
                    type: 'GET',
                    dataType: 'json',
                    async: false,
                    success: function(membersData) {
                        //organizations[data[i].login] = membersData.length;
                        obj[login] = membersData.length;
                        organizations.push(obj);
                    }
                })
            }
            drawChart(formatArray(organizations))
        }

    });
}

$(document).on('ready page:load', function () {
    ajaxGetOrganizationsData();
})
