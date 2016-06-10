class PrintRequestsController < ApplicationController
  before_action :set_print_request, only: [:show, :edit, :update, :destroy]

  # GET /print_requests
  # GET /print_requests.json
  def index
    @print_requests = PrintRequest.all
  end

  # GET /print_requests/1
  # GET /print_requests/1.json
  def show
  end

  # GET /print_requests/new
  def new
    @print_request = PrintRequest.new
  end

  # GET /print_requests/1/edit
  def edit
  end

  # POST /print_requests
  # POST /print_requests.json
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

  # PATCH/PUT /print_requests/1
  # PATCH/PUT /print_requests/1.json
  def update
    respond_to do |format|
      if @print_request.update(print_request_params)
        format.html { redirect_to @print_request, notice: 'Print request was successfully updated.' }
        format.json { render :show, status: :ok, location: @print_request }
      else
        format.html { render :edit }
        format.json { render json: @print_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /print_requests/1
  # DELETE /print_requests/1.json
  def destroy
    @print_request.destroy
    respond_to do |format|
      format.html { redirect_to print_requests_url, notice: 'Print request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_print_request
      @print_request = PrintRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def print_request_params
      params.fetch(:print_request, {})
    end
end
