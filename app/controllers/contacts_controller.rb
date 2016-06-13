class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :destroy]
  skip_before_action :authenticate_user!

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
    @contact = Contact.new(group_params)

    if @contact.save
      flash.now[:notice] = 'Entraremos em contato em breve!'
    else
      flash.now[:error] = 'Cannot send message.'
    end

    redirect_to root_path
  end

  def destroy
    @contact.destroy

    respond_with(@contact)
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def group_params
    params.require(:contact).permit(:name, :email, :status, :message)
  end
end
