class SessionsController < ApplicationController
  before_action :set_client
  before_action :set_project
  before_action :set_session, only: [:wait, :finish, :cancel, :destroy]

  def index
    @sessions = @project.sessions.all
    set_new_session

    respond_with(@sessions, location: client_project_sessions_path(@client, @project))
  end

  def cancel
    @session.canceled!
    @session.save

    redirect_to client_project_sessions_path(@client, @project)
  end

  def finish
    @session.finished!
    @session.save

    redirect_to client_project_sessions_path(@client, @project)
  end

  def wait
    @session.waiting!
    @session.save

    redirect_to client_project_sessions_path(@client, @project)
  end

  def create
    @session = @project.sessions.build(session_params)
    @session.waiting!

    if @session.save
      redirect_to client_project_sessions_path(@client, @project)
    else
      @session.build_address

      render :index
    end
  end

  def destroy
    @session.destroy

    redirect_to sessions_url, notice: 'Session was successfully destroyed.'
  end

  private

  def set_new_session
    @session = @project.sessions.build(status: SessionStatus::WAITING)
    @session.build_address
  end

  def set_client
    @client = User.client.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:project_id])
  end

  def set_session
    @session = @project.sessions.find(params[:id])
  end

  def session_params
    attributes = {
      address_attributes: [:nick, :reference, :city, :state, :zipcode, :street]
    } unless params[:session] && params[:session][:address_id] != 0

    params.require(:session).permit(:start_at, :finish_at, :address_id, :status, attributes)
  end
end