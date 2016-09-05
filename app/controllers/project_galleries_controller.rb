class ProjectGalleriesController < ApplicationController
  before_action :set_project
  before_action :can_show_project?, only: :index

  layout 'devise_gray'

  skip_before_action :authenticate_user!

  def index
    @media = @project.galleries.map(&:media).flatten
    @width = if @media.count >= 250
              '160px'
             elsif @media.count > 50
              '200px'
             end
  end

  def unlock
    if params.key? :project
      set_project(params[:project][:code])

      can_show_project?
    end
  end

  def locked
    @newsletter = @project.newsletters.build

    respond_with(@newsletter, location: locked_project_gallery_path(@project.code))
  end

  def update
    @newsletter = @project.newsletters.build(newsletter_params)

    if @newsletter.save
      redirect_to works_path, notice: 'Assim que tudo estiver preparado, você saberá em primeira mão! Enquanto espera, porque não dar uma olhada no que eu já fiz?!'
    else
      flash.now[:alert] = 'Não foi possível adicionar a sua inscrição.'

      render :locked
    end
  end

  private

  def set_project(code = params[:code])
    @project = Project.find_by_code(code)
  end

  def can_show_project?
    code = params[:code] || params[:project][:code]

    if @project.blank?
      redirect_to unlock_project_galleries_path, warning: "Ops, não existe nenhum projeto com o código: #{code}"
    elsif !@project.launched?
      flash.now[:warning] = 'Estamos trabalhando neste projeto no momento!'

      redirect_to locked_project_gallery_path(@project.code), warning: 'Desculpe! mas este projeto ainda não está disponível!'
    end
  end

  def newsletter_params
    params.require(:newsletter).permit(:name, :email, :project_id)
  end
end
