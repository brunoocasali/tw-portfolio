module NoticeManagerHelper
  def notices
    flash.reject { |_, m| m.eql? true }.collect do |key, msg|
      content_tag :div, id: 'bootstrap-alert', class: "alert alert-#{alert_class_finder(key)}", role: :alert do
        concat(msg).concat(content_tag(:button, '×', class: 'close', data: { dismiss: 'alert' }))
      end
    end.join.html_safe
  end

  private

  def alert_class_finder(key)
    case key
    when 'notice'
      'success'
    when 'alert'
      'danger'
    when 'warning'
      'warning'
    end
  end
end
