class ProjectGalleriesController < ApplicationController
  before_action :set_project
  before_action :can_show_project?, only: :index

  skip_before_action :authenticate_user!

  def index
  end

  def unlock
    binding.pry
    if params.key? :project
      set_project(params[:project][:code])

      redirect_to project_gallery_path(@project.code)
    end
  end

  def locked
    @newsletter = @project.newsletters.build

    respond_with(@newsletter, location: locked_project_gallery_path(@project.code))
  end

  def update
    @newsletter = @project.newsletters.build(newsletter_params)

    if @newsletter.save
      redirect_to root_path, notice: 'Assim que tudo estiver preparado, você saberá em primeira mão!'
    else
      flash.now[:alert] = 'Não foi possível adicionar a sua inscrição.'

      render :locked
    end
  end

  private

  def set_project(code = params[:code])
    @project = Project.find_by_code(params[:code])
  end

  def can_show_project?
    unless @project.launched?
      flash.now[:warning] = 'Estamos trabalhando neste projeto no momento!'

      redirect_to locked_project_gallery_path(@project.code), warning: 'Desculpe! mas este projeto ainda não está disponível!'
    end
  end

  def newsletter_params
    params.require(:newsletter).permit(:name, :email, :project_id)
  end
end
