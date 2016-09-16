class BaseMailer < ApplicationMailer
  def about_work(project_id)
    @project = Project.find(project_id)

    do_the_job 'Tatiana Wacelkoski: Sobre Meu Trabalho'
  end

  def almost_done(project_id)
    @project = Project.find(project_id)

    do_the_job 'Tatiana Wacelkoski: Está quase pronto!'
  end

  def finished_project(project_id)
    @project = Project.find(project_id)

    do_the_job 'T. Wacelkoski Fotografias: Suas fotos estão prontas, confira!'
  end

  private

  def do_the_job(subject)
    emails = @project.newsletters.to_a << @project.owner

    emails.each do |m|
      @contact = m

      mail(to: m.email, subject: subject)
    end
  end
end
