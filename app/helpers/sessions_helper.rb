module SessionsHelper
  SESSION_COLORS = { '0': 'red', '1': 'orange', '2': 'green' }

  def from_status_to_color(status)
    SESSION_COLORS[status.to_s.to_sym]
  end
end
