class UtilsController < ApplicationController
  def complete_address
    address = BuscaEndereco.cep(params[:zipcode])

    respond_with(address)
  end
end
