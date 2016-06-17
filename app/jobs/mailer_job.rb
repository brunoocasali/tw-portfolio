class MailerJob < Struct.new(:emails, :which_content, :project_id)
  def perform
    BaseMailer.send(which_content, emails, Project.find(project_id)).deliver!
  end
end
