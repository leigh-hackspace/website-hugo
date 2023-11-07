$(document).ready(function () {
  $(".navbar-burger").click(function () {
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");
  });

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
  }
});

function render_calendar() {
  const calendar = new tui.Calendar('#calendar', {
    defaultView: 'month',
    isReadOnly: true,
    useDetailPopup: true,
    usageStatistics: false,
    month: {
      startDayOfWeek: 1,
      visibleWeeksCount: 4,
    },
    calendars: [
      {
        id: '1',
        name: 'Hackspace Events',
        backgroundColor: '#d41246',
      },
    ],
  });

  $.getJSON('https://api.leighhack.org/events', function (data) {
    data.forEach(function (event) {
      calendar.createEvents([{
        id: event['uid'],
        calendarId: '1',
        title: event['summary'],
        body: event['description'],
        state: 'Free',
        dueDateClass: '',
        start: event['start']['dateTime'],
        end: event['end']['dateTime'],
      }])
    });
  });
  calendar.render();
}



