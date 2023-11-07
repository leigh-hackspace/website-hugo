$(document).ready(function () {
  $(".navbar-burger").click(function () {
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");
  });

  if ($('span#hackspace-status').length) {
    $.getJSON("https://api.leighhack.org/space.json", function (data) {
      var date = new Date(data.state.lastchange * 1000);

      if (data.state.open) {
        message = '<b>Open<b>'
        if ('message' in data.state) {
          message = message + ': ' + data.state.message;
        }
        $('span#hackspace-status').html(message);
        $('div#hackspace-open').addClass('is-success');
      } else {
        $('span#hackspace_status').html('<b>Closed</b>');
      }
    });
  }
});



