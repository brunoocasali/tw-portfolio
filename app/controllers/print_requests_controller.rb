class PrintRequestsController < ApplicationController
  before_action :set_client
  before_action :set_project
  before_action :set_print_request, only: [:show, :destroy]

  def index
    @print_requests = @project.print_requests.page(params[:page])
  end

  def show; end

  def new
    @print_request = PrintRequest.new
  end

  def create
    @print_request = PrintRequest.new(print_request_params)

    respond_with(@print_request, location: client_project_print_requests_path(@client, @project))
  end

  def destroy
    @print_request.destroy

    respond_with(@print_request, location: client_project_print_requests_path(@client, @project))
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:project_id])
  end

  def set_print_request
    @print_request = PrintRequest.find(params[:id])
  end

  def print_request_params
    params.require(:print_request).permit(:quantity, :status, :message, :size, :medium_id)
  end
end
