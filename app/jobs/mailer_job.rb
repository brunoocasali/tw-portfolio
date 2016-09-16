class MailerJob < Struct.new(:which_content, :project_id)
  def perform
    BaseMailer.send(which_content, project_id).deliver_now!
  end
end
