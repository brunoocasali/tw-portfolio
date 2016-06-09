class ProjectsController < ApplicationController
  before_action :set_client
  before_action :set_project, only: [:show, :edit, :update, :destroy, :dashboard]

  def index
    @projects = @client.projects.page(params[:page])
  end

  def show; end

  def new
    @project = @client.projects.build(status: ProjectStatus::INITIATED)
  end

  def edit; end

  def create
    @project = @client.projects.build(project_params)
    @project.save

    respond_with @project, location: client_projects_path(@client)
  end

  def update
    @project.update(project_params)

    respond_with @project, location: client_projects_path(@client)
  end

  def destroy
    @project.destroy

    respond_with @project, location: client_projects_path(@client)
  end

  private

  def set_project
    @project = @client.projects.find(params[:id])
  end

  def set_client
    @client = User.client.find(params[:client_id])
  end

  def project_params
    params.require(:project).permit(:name, :status, :code, :owner_id)
  end
end
