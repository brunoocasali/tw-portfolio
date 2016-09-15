class BaseMailer < ApplicationMailer
  def about_work(project_id)
    @project = Project.find(project_id)

    emails = @project.newsletters.to_a << @project.owner

    mail(to: emails, subject: 'Tatiana Wacelkoski: Sobre Meu Trabalho')
  end

  def almost_done(project_id)
    @project = Project.find(project_id)

    emails = @project.newsletters.to_a << @project.owner

    mail(to: emails, subject: 'Tatiana Wacelkoski: Está quase pronto!')
  end

  def finished_project(project_id)
    @project = Project.find(project_id)

    emails = @project.newsletters.to_a << @project.owner

    emails.each do |m|
      @contact = m

      mail(to: m.email, subject: 'T. Wacelkoski Fotografias: Suas fotos estão prontas, confira!')
    end
  end
end
