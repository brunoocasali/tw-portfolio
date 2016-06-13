module OptionsConverter
  def convert_html_options(super_options: required, options: required)
    classes = ['form-control']
    classes << [super_options[:class]] if super_options[:class]
    classes << [options[:class]] if options[:class]
    classes = classes.flatten
    options.merge(super_options).merge(class: classes)
  end
end
