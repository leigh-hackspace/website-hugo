
var events = [];
$(document).ready(function () {
    $.getJSON('https://api.leighhack.org/events', function (data) {
        data.forEach(function (event) {
            events.push({
                id: event['uid'],
                title: event['summary'],
                body: event['description'],
                state: 'Free',
                dueDateClass: '',
                start: event['start']['dateTime'],
                end: event['end']['dateTime'],
            })
        });
        let ec = new EventCalendar(document.getElementById('calendar'), {
            view: 'listMonth',
            events: events,
            headerToolbar: {
                start: 'prev,next today',
                center: 'title',
                end: 'dayGridMonth, listMonth'
            },
        });
    });
});
