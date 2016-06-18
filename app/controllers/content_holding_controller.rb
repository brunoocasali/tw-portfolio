class ContentHoldingController < ApplicationController
  skip_before_action :authenticate_user!

  def check
    binding.pry
    begin
      Rails.application.routes.recognize_path(request.path)

      redirect_to request
    rescue
      code = if request.path =~ (/ensaios\/unlock/)
               params[:code] || params[:project][:code]
             else
              request.path.gsub('/', '')
             end

      if Project.exists?(code: code)
        redirect_to project_gallery_path(code: code)
      else
        redirect_to unlock_project_galleries_url(code: code), alert: 'Ops! Não existe nenhum projeto com esse código, tente novamente!'
      end
    end
  end
end
