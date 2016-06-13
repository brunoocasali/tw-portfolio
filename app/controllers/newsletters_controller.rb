class NewslettersController < ApplicationController
  before_action :set_client
  before_action :set_project

  def index
    @newsletters = @project.newsletters.order(created_at: :asc).page(params[:page])
  end

  private

  def set_client
    @client = User.client.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:project_id])
  end
end
