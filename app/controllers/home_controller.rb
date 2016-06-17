class HomeController < ApplicationController
  def index
    @contact = Contact.new
    @galleries = Project.launched.order(created_at: :desc).limit(4).map(&:galleries).flatten.select(&:show?)
  end
end
