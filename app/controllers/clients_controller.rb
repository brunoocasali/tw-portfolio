class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :dashboard]

  def index
    @clients = Client.client.page(params[:page])
  end

  def show; end

  def dashboard; end

  def complete_address
    address = BuscaEndereco.cep(params[:zipcode])

    respond_with(address)
  end

  def new
    @client = Client.new
    @client.build_address
    @client.client!
  end

  def edit; end

  def create
    @client = Client.new(client_params)
    @client.client!
    @client.save

    respond_with @client, location: clients_path
  end

  def update
    @client.update(client_params)

    respond_with @client, location: clients_path
  end

  def destroy
    @client.destroy

    respond_with @client, location: clients_path
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client)
      .permit(:name, :phone, :email,
              address_attributes: [:nick, :reference, :city, :state, :zipcode, :street])
  end
end
