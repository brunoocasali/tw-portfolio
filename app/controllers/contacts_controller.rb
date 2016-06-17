class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: :create

  def index
    @contacts = Contact.order(status: :asc).page(params[:page])

    respond_with(@contacts)
  end

  def show
    if @contact.unread?
      @contact.read!
      @contact.save!
    end

    respond_with(@contact)
  end

  def new
    @contact = Contact.new

    respond_with(@contact)
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.new_contact(@contact.id).deliver!

      redirect_to root_path, notice: 'Entraremos em contato em breve!'
    else
      flash.now[:alert] = 'Não foi possível enviar sua mensagem.'

      render template: 'home/index', layout: 'home_page'
    end
  end

  def destroy
    @contact.destroy

    respond_with(@contact)
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :status, :message)
  end
end
