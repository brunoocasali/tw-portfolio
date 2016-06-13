class NewslettersController < ApplicationController
  before_action :set_client
  before_action :set_project

  def index
    @newsletters = @project.newsletters.order(created_at: :asc).page(params[:page])
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_with @newsletter, location: client_project_newsletters_path(@client, @project)
  end

  private

  def set_client
    @client = User.client.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:project_id])
  end

  def newsletter_params
    params.require(:newsletter).permit(:name, :email, :project_id)
  end
end
