class ProjectsController < ApplicationController
  before_action :set_client
  before_action :set_project, except: [:index, :new]

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

  def deliver
    @project.launched!
    @project.save!

    to_emails = @project.newsletters.map(&:email)
    to_emails << @project.owner.email

    Delayed::Job.enqueue(MailerJob.new(to_emails, :finished_project, @project.id))

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
    @client = User.client.find(params[:client_id])
  end

  def project_params
    params.require(:project).permit(:name, :status, :code, :owner_id)
  end
end
