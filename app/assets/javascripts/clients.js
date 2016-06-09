function loadCEP(){
    var cep = $("#user_address_attributes_zipcode").val();

    if (cep.length >= 8 && cep.length <= 9){
      $.getJSON('/clients/complete_address/' + cep + '.json',
          function (data) {
              ids = {
                  user_address_attributes_street: data.tipo_logradouro + ' ' + data.logradouro,
                  user_address_attributes_city: data.cidade,
                  user_address_attributes_state: data.uf
              };

              $.each(ids, function(key, value) {
                  $("#" + key).val(value);
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
