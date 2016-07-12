class NewslettersController < ApplicationController
  before_action :set_client
  before_action :set_project

  def index
    @newsletters = @project.newsletters.order(created_at: :asc).page(params[:page])
  end

  def mail_about_work
    newsletters = @project.newsletters

    Delayed::Job.enqueue(MailerJob.new(newsletters.map(&:email), :about_work, @project.id))

    respond_with @project, location: client_project_newsletters_path(@client, @project), notice: t('processing_mails')
  end

  def mail_project_almost_done; end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:project_id])
  end
end
