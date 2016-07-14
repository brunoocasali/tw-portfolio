$('#calendar').fullCalendar({
  events: '/welcome/sessions.json',
  startParam: 'start_at',
  endParam: 'finish_at',
  lang: 'pt-br',
  header: {
      left: 'prev,next today myCustomButton',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
  },
  eventClick:  function(event, jsEvt, view) {
    $('#modalTitle').html(event.title);
    $('#modalBody').html(event.description);

    $('#cancel_btn').attr('href', 'sessions/' + event.id + '/cancel');
    $('#wait_btn').attr('href', 'sessions/' + event.id + '/wait');
    $('#finish_btn').attr('href', 'sessions/' + event.id + '/finish');

    $('#fullCalModal').modal();
  },
  dayClick: function(date, jsEvt, view) {
    $('#session_start_at').val(date.format('DD-MM-YYYY HH:mm'));
    $('#session_start_at').trigger('input');
    $('#fullCalCreateModal').modal();
  }
});
