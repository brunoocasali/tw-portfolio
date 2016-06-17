class WorksController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'devise_gray'

  def index
    @galleries = Project.launched.map(&:galleries).flatten.select(&:show?)
  end
end
