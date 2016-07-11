'use strict';

$(document).ready(function() {
  function set_mask() {
    $('.mask').each(function(){
      var input = $(this);
      input.mask(input.data('maskFormat'), {reverse: input.data('maskReverse'),
                                                     placeholder: input.data('maskPlaceholder'),
                                                     mask_maxlength: input.data('maskMaxlength') });
    });
  }

  function set_phone_mask() {
    var phone_input = $('.phone_mask');

    var phoneMaskBehavior = function (val) {
      return val.replace(/\D/g, '').length === phone_input.data('maskCustomLength') ?
                                               phone_input.data('maskFormatCustom') :
                                               phone_input.data('maskFormatDefault');
    };

    var phoneOptions = {
      onKeyPress: function(val, e, field, options) {
        field.mask(phoneMaskBehavior.apply({}, arguments), options);
      }
    };

    phone_input.mask(phoneMaskBehavior, phoneOptions);
  }

  set_mask();
  set_phone_mask();

  $('body')
    .on('cocoon:after-insert', function(element, insertedItem) {
      set_mask();
      set_phone_mask();
    })
});
