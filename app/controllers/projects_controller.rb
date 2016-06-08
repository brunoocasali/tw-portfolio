class ProjectsController < ApplicationController
  before_action :set_client
  before_action :set_project, only: [:show, :edit, :update, :destroy, :dashboard]

  # GET /projects
  def index
    @projects = @client.projects.all
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = @client.projects.find(params[:id])
  end

  def set_client
    @client = User.client.find(params[:client_id])
  end

  def project_params
    params[:project]
  end
end
