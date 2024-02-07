function titleCase(word) {
    return word.charAt(0).toUpperCase() + word.substr(1).toLowerCase();
}

// SpaceAPI related calls and data
$(document).ready(function () {

    $.getJSON("https://api.leighhack.org/space.json", function (data) {

        // Hackspace status
        if ($('span#hackspace-status').length) {
            if (data.state.open) {
                message = '<b>Open<b>'
                if ('message' in data.state) {
                    message = message + ': ' + data.state.message;
                }
                $('span#hackspace-status').html(message);
                $('div#hackspace-open').addClass('is-success');
            } else {
                $('span#hackspace-status').html('<b>Closed</b>');
            }
            console.log(atob('aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1IcDdBSVh5UkpwdyAtIERhYm8uLi4u'));
        }

        // 'printers' shortcode
        if ($('div#printer-status').length) {
            if (data.sensors.ext_3d_printers.length) {

                // sort the printers
                const printers = Array.from(data.sensors.ext_3d_printers).sort((a, b) => a['name'].localeCompare(b['name']));

                printers.forEach(function (val, indx) {
                    var obj = $($("template#printer-block").html());
                    obj.find('#printer-name').html(val['name']);
                    obj.find('#printer-status').html(titleCase(val['state']));
                    $('div#printer-status').append(obj);
                });
            }
        }

        // 'map' shortcode
        if ($('div#map').length) {
            center = ol.proj.fromLonLat([data.location.lon, data.location.lat])

            // Create map
            const map = new ol.Map({
                target: document.getElementById('map'),
                layers: [
                    new ol.layer.Tile({
                        source: new ol.source.OSM(),
                    }),
                    new ol.layer.Vector({
                        source: new ol.source.Vector({
                            features: [new ol.Feature({
                                geometry: new ol.geom.Point(center),
                                name: "Leigh Hackspace",
                            })]
                        }),
                        style: new ol.style.Style({
                            image: new ol.style.Icon({
                              scale: .06,
                              anchorXUnits: 'fraction',
                              anchorYUnits: 'pixels',
                              src: '../images/rose_logo.svg',
                            }),
                          }),
                    })
                ],
                view: new ol.View({
                    center: center,
                    maxZoom: 18,
                    zoom: 13,
                }),
            });
        }
    });
});
