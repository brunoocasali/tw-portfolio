class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :destroy]

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
    @contact.save

    respond_with(@contact)
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
    params.require(:group).permit(:name, :email, :status, :message)
  end
end
