class ProjectGalleriesController < ApplicationController
  before_action :set_project

  skip_before_action :authenticate_user!

  def index
  end

  def unlock
  end

  def locked
    @newsletter = @project.newsletters.build

    respond_with(@newsletter, location: locked_project_gallery_path(@project))
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

  def set_project
    @project = Project.find_by_code(params[:code])
  end

  def newsletter_params
    params.require(:newsletter).permit(:name, :email, :project_id)
  end
end
