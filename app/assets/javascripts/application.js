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
//= require grayscale
//= require angular
//= require moment
//= require fullcalendar
//= require fullcalendar/lang-all
//= require fittext
//= require image-picker
//= require wow
//= require flickity
//= require jQuery-Mask-Plugin
//= require dropzone
//= require angular_module
//= require calendars
//= require jquery.easing
//= require isotope.pkgd.min
//= require_tree ./core
//= require_self

$('.image-picker').imagepicker({
  hide_select : true,
  show_label  : false
});

$(document).ready(function() {
  $('.fc-toolbar').find('.fc-button-group').addClass('btn-group');
  $('.fc-toolbar').find('.fc-button').addClass('btn btn-danger').removeClass('fc-prev-button fc-button fc-state-default fc-corner-left fc-next-button fc-corner-right');
  $('.fc-toolbar').find('.fc-prev-button').html($('<span />').attr('class', 'glyphicon glyphicon-chevron-left'));
  $('.fc-toolbar').find('.fc-next-button').html($('<span />').attr('class', 'glyphicon glyphicon-chevron-right'));
});

//sessions
$(document).ready(function() {
  changed_address();
});

$("#session_address_id").change(function(){
  changed_address();
});

function changed_address(){
  var id = $("#session_address_id").find("option:selected").attr('value');

  if (id == 0){
    $('#address_form').removeClass('hide');
  }

  if (id == '' || id != 0) {
    $('#address_form').addClass('hide');
  }
}

var template = '<div class="dz-preview dz-image-preview">' +
                '<div class="dz-image"><img data-dz-thumbnail=""></div>' +
                '<div class="dz-details">' +
                  '<div class="dz-filename"><span data-dz-name></span></div>' +
                  '<div class="dz-size" data-dz-size></div>' +
                '</div>' +
                '<div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>' +
                '<div class="dz-success-mark"><span>✔</span></div>' +
                '<div class="dz-input">' +
                  '<input type="text" style="cursor: auto !important;" class="form-control input-sm dropzone-input js-caption" placeholder="Legenda" name="caption"/>' +
                  '<div class="checkbox to-left">' +
                      '<label title="Disponível apenas para quem possuír o código"><input type="checkbox" class="js-show"/> <i class="fa fa-unlock"></i></label>'+
                      '<label class="pull-right" title="Tornar a capa da galeria"><input type="checkbox" class="js-cover"/> <i class="fa fa-star" style="color: #E38C2D"></i></label>'+
                  '</div>' +
                '</div>' +
                '<div class="btn-group">' +
                  '<a href="javascript:undefined;" style="width: 60px" class="bt btn btn-sm btn-default save-btn"><i class="fa fa-save"></i></a>' +
                  '<a href="javascript:undefined;" style="width: 60px" class="bt btn btn-sm btn-danger" data-dz-remove><i class="fa fa-trash-o"></i></a>' +
                '</div>' +
              '</div>'

Dropzone.options.mediaDropzone = {
  paramName: 'file',
  maxFilesize: 6,
  maxFiles: 6,
  autoProcessQueue: true,
  dictDefaultMessage: 'Arraste e solte arquivos aqui, para fazer o upload',
  previewTemplate: template,
  init: function() {
    var thisDropzone = this;

    $.getJSON(($("#mediaDropzone").attr("action")) + '.json', function(data) {
      $.each(data, function(k, v){
        var mockFile = {
          name: v.filename.url.substr(v.filename.url.lastIndexOf('/') + 1),
          id: v.id, size: v.file_size
        };

        thisDropzone.emit("addedfile", mockFile);
        thisDropzone.emit("thumbnail", mockFile, v.filename.medium.url);
        thisDropzone.emit("complete", mockFile);
        thisDropzone.emit("success", mockFile, v);
      });
    });

    this.on('removedfile', function(file) {
      $.ajax({
        url: $("#mediaDropzone").attr("action") + "/" + file.id,
        type: 'DELETE'
      });
    });

    this.on('success', function(file, response) {
      var id = response.id;
      // get element
      var elem = $('a.save-btn:not([onclick])').first()
      elem.attr('onclick', 'update(' + id + ')');
      // get parent and add id to it.
      preview_elem = elem.parent().parent();
      preview_elem.find('.js-caption').attr('id', 'caption-' + id);
      preview_elem.find('.js-cover').attr('id', 'cover-' + id);
      preview_elem.find('.js-show').attr('id', 'show-' + id);

      $('#caption-' + id).val(response.subtitle);
      $('#show-' + id).attr('checked', response.show);
      $('#cover-' + id).attr('checked', response.cover);
    });
  }
}

function update(id){
  $.ajax({
    url: $("#mediaDropzone").attr("action") + "/" + id,
    type: 'PUT',
    data: {
      caption: $('#caption-' + id).val(),
      show: $('#show-' + id).is(':checked'),
      cover: $('#cover-' + id).is(':checked')
    }
  });

  location.reload();
}


$(function() {
  function nextBackground() {
    $("#intro-header").fadeIn("slow", function() {
      items = [1, 2];
      var item = items[Math.floor(Math.random() * items.length)];

      $("#intro-header").removeClass (function (index, css) {
          return (css.match(/intro[0-9]+/).join(' '));
      });

      $(this).addClass("intro" + item);
    });

    setTimeout(nextBackground, 8000);
  }

  setTimeout(nextBackground, 8000);
});
