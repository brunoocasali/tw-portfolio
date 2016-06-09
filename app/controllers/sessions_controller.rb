class SessionsController < ApplicationController
  before_action :set_client
  before_action :set_project
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  def index
    @sessions = @project.sessions.all
    set_new_session

    respond_with(@sessions, location: client_project_sessions_path(@client, @project))
  end

  def show; end

  def edit; end

  def create
    @session = @project.sessions.build(session_params)
    @session.waiting!

    if @session.save
      redirect_to client_project_sessions_path(@client, @project)
    else
      render :index
    end
  end

  def update
    if @session.update(session_params)
      redirect_to @session, notice: 'Session was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @session.destroy
    redirect_to sessions_url, notice: 'Session was successfully destroyed.'
  end

  private

  def set_new_session
    params = { status: SessionStatus::WAITING, start_at: Time.zone.now, finish_at: Time.zone.now + 2.hours }

    @session = @project.sessions.build(params)
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
