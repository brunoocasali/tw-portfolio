class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :dashboard]

  def index
    @clients = User.client.page(params[:page])
  end

  def show; end

  def dashboard; end

  def complete_address
    address = BuscaEndereco.cep(params[:zipcode])

    respond_with(address)
  end

  def new
    @client = User.new
    @client.build_address
    @client.client!
  end

  def edit; end

  def create
    @client = User.new(client_params)
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
    @client = User.client.find(params[:id])
  end

  def client_params
    params.require(:user)
      .permit(:name, :phone, :email,
              address_attributes: [:nick, :reference, :city, :state, :zipcode, :street])
  end
end
