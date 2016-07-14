require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  add_flash_types :warning

  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: 'devise_controller? || home_page?'

  layout :layout_by_resource

  respond_to :html, :json

  protected

  def home_page?
    controller_name.eql?('home')
  end

  def layout_by_resource
    if devise_controller?
      'devise'
    elsif home_page?
      'home_page'
    else
      'application'
    end
  end
end
