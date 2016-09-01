class HomeController < ApplicationController
  def index
    @contact = Contact.new
    @galleries = Project.launched.order(created_at: :desc).map(&:galleries).flatten.select(&:show?).take(4)
  end
end
