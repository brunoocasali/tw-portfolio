class ProjectsController < ApplicationController
  before_action :set_client
  before_action :set_project, except: [:create, :index, :new]

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

    if @project.save
      respond_with @project, location: dashboard_client_project_path(@client, @project)
    else
      respond_with @project, location: [@client, @project]
    end
  end

  def update
    @project.update(project_params)

    respond_with @project, location: client_projects_path(@client)
  end

  def deliver
    @project.launched!
    @project.save!

    Delayed::Job.enqueue(MailerJob.new(:finished_project, @project.id))

    respond_with @project, location: client_projects_path(@client), notice: 'Projeto disponibilizado com sucesso! Estamos preparando um email especial para todos os espectadores!'
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
    @client = Client.find(params[:client_id])
  end

  def project_params
    params.require(:project).permit(:name, :status, :code, :owner_id)
  end
end
