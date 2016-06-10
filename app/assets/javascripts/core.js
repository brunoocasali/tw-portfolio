var App = angular.module('app', []);

App.controller('ProjectsController', function($scope) {});

function loadCEP(){
    var cep = $("#zipcode").val();

    if (cep.length >= 8 && cep.length <= 9){
      $.getJSON('/utils/complete_address/' + cep + '.json',
          function (data) {
              ids = {
                  street: data.tipo_logradouro + ' ' + data.logradouro,
                  city: data.cidade,
                  state: data.uf
              };

              $.each(ids, function(key, value) {
                $("[id$=_" + key + "]").val(value);
              });
          }
      ).error(function() {
        $('#alert_cep').removeClass('hide');
        $('.alert').fadeTo(3000, 500).slideUp(500, function(){
          $('#bootstrap-alert').alert('close');
        });
      });
    }
}
