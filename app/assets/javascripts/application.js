// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require angular
//= require moment
//= require fullcalendar
//= require fullcalendar/lang-all
//= require fittext
//= require image-picker
//= require wow
//= require jQuery-Mask-Plugin
//= require dropzone
//= require angular_module
//= require calendars
//= require core
//= require_self

$('.image-picker').imagepicker({
  hide_select : true,
  show_label  : false
});

$(document).ready(function() {
  var input = $('.mask');
  input.mask(input.data('maskFormat'), {reverse: input.data('maskReverse'), placeholder: input.data('maskPlaceholder'), mask_maxlength: input.data('maskMaxlength')});

  $('.fc-toolbar').find('.fc-button-group').addClass('btn-group');
  $('.fc-toolbar').find('.fc-button').addClass('btn btn-danger').removeClass('fc-prev-button fc-button fc-state-default fc-corner-left fc-next-button fc-corner-right');
  $('.fc-toolbar').find('.fc-prev-button').html($('<span />').attr('class', 'glyphicon glyphicon-chevron-left'));
  $('.fc-toolbar').find('.fc-next-button').html($('<span />').attr('class', 'glyphicon glyphicon-chevron-right'));
});

//sessions
$("#session_address_id").change(function(){
  var id = $(this).find("option:selected").attr('value');

  if (id == 0){
    $('#address_form').removeClass('hide');
  }

  if (id == '' || id != 0) {
    $('#address_form').addClass('hide');
  }
});

Dropzone.options.mediaDropzone = {
  paramName: 'file',
  maxFilesize: 15,
  dictDefaultMessage: 'Arraste e solte arquivos aqui, para fazer o upload',
  addRemoveLinks: true,
  dictRemoveFile: 'Deletar',
  init: function() {
    var thisDropzone = this;

    $.getJSON(($("#mediaDropzone").attr("action")) + '.json', function(data) {
        $.each(data, function(k, v){
          var mockFile = {
            name: v.filename.url.substr(v.filename.url.lastIndexOf('/') + 1),
            id: v.id, size: v.file_size
          };

          thisDropzone.emit("addedfile", mockFile);
          thisDropzone.emit("thumbnail", mockFile, v.filename.url);
          thisDropzone.emit("complete", mockFile);
      });
    });

    this.on('removedfile', function(file) {
      console.log(file)
      $.ajax({
        url: $("#mediaDropzone").attr("action") + "/" + file.id,
        type: 'DELETE'
      });
    });
  }
};
