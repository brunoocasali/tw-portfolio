class ContactMailer < ApplicationMailer
  def new_contact(id)
    @contact = Contact.find(id)

    mail(to: 'ola@wacelkoski.com', subject: 'Novo Contato: Tatiana Wacelkoski')
  end
end
