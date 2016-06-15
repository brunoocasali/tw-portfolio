class BaseMailer < ApplicationMailer
  def about_work(emails, project_id)
    mail(to: emails, subject: 'Tatiana Wacelkoski: Sobre Meu Trabalho')
  end

  def almost_done(emails, project_id)
    mail(to: emails, subject: 'Tatiana Wacelkoski: Está quase pronto!')
  end

  def finished_project(emails, project_id)
    mail(to: emails, subject: 'Tatiana Wacelkoski: Tudo pronto, veja as fotos aqui!')
  end

  # email para:
  # - falar sobre o trabalho dela. (manual)
  # - falar sobre o projeto, que está quase pronto. (manual)
  # - falar sobre o projeto, que está finalizado. (automático)
  # - felicitando de aniversário... (automático, e precisa pegar a data de aniversário)
end
