class CellphoneInput < SimpleForm::Inputs::Base
  include OptionsConverter

  def input(_wrapper_options)
    @builder.text_field(attribute_name, input_html_options)
  end

  private

  def input_html_options
    convert_html_options super_options: super,
                         options: {
                           data: {
                             mask_custom_length: ::I18n.t('simple_form.mask.phone.custom_length'),
                             mask_format_default: ::I18n.t('simple_form.mask.phone.format_default'),
                             mask_format_custom: ::I18n.t('simple_form.mask.phone.format_custom'),
                             mask_placeholder: ::I18n.t('simple_form.mask.phone.placeholder')
                           },
                           class: 'phone_mask'
                         }
  end
end
