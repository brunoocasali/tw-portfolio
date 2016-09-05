class AllowedRouteValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    path = Rails.application.routes.recognize_path("/#{value}", method: :get) rescue nil
    record.errors.add(attribute, "já existe um caminho com este nome: (/#{value})") if path && !path[attribute]
  end
end
