function titleCase(word) {
    return word.charAt(0).toUpperCase() + word.substr(1).toLowerCase();
}

$(document).ready(function () {
    if ($('span#hackspace-status').length) {
        $.getJSON("https://api.leighhack.org/space.json", function (data) {
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
        });
        console.log(atob('aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1IcDdBSVh5UkpwdyAtIERhYm8uLi4u'));
    }

    // 'printers' shortcode
    if ($('div#printer-status').length) {
        $.getJSON("https://api.leighhack.org/space.json", function (data) {
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
        });
    }
});
