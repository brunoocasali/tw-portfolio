module ApplicationHelper
  def active_class(name)
    controller_name.eql?(name) || current_page?(name) ? 'active' : ''
  end

  def actual_asset(controller)
    return controller if $assets.include? controller

    nil
  end
end

