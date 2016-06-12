class PrintRequestsController < ApplicationController
  before_action :set_print_request, only: [:show, :destroy]

  def index
    @print_requests = PrintRequest.page(params[:page])
  end

  def show; end

  def new
    @print_request = PrintRequest.new
  end

  def create
    @print_request = PrintRequest.new(print_request_params)

    respond_to do |format|
      if @print_request.save
        format.html { redirect_to @print_request, notice: 'Print request was successfully created.' }
        format.json { render :show, status: :created, location: @print_request }
      else
        format.html { render :new }
        format.json { render json: @print_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @print_request.destroy
    respond_to do |format|
      format.html { redirect_to print_requests_url, notice: 'Print request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_print_request
    @print_request = PrintRequest.find(params[:id])
  end

  def print_request_params
    params.fetch(:print_request, {})
  end
end
