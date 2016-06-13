class WelcomeController < ApplicationController
  def index
    @print_requests = PrintRequest.last(5).reverse
    @contacts = Contact.last(5).reverse
  end

  def sessions
    @sessions = Session.all

    respond_with(@sessions, location: sessions_welcome_index_path)
  end
end
