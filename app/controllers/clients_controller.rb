class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :dashboard]

  # GET /clients
  def index
    @clients = User.client.page(params[:page])
  end

  # GET /clients/1
  def show
  end

  # GET /clients/1/dashboard
  def dashboard
  end

  # GET /clients/new
  def new
    @client = User.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  def create
    @client = User.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params[:client]
    end
end
