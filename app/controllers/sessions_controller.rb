class SessionsController < ApplicationController
  before_action :set_client
  before_action :set_project
  before_action :set_session, only: [:wait, :finish, :cancel, :remove]

  def index
    @session = @project.sessions.build(status: SessionStatus::WAITING)
    @session.build_address

    respond_with(@session, location: client_project_sessions_path(@client, @project))
  end

  def cancel
    @session.canceled!
    @session.save

    redirect_to client_project_sessions_path(@client, @project), notice: 'Ensaio Cancelado!'
  end

  def finish
    @session.finished!
    @session.save

    redirect_to client_project_sessions_path(@client, @project), notice: 'Ensaio Finalizado!'
  end

  def wait
    @session.waiting!
    @session.save

    redirect_to client_project_sessions_path(@client, @project), notice: 'Ensaio em Espera!'
  end

  def create
    @session = @project.sessions.build(session_params)
    @session.waiting!

    if @session.save
      respond_with @session, location: client_project_sessions_path(@client, @project)
    else
      render :index
    end
  end

  def remove
    @session.destroy

    redirect_to client_project_sessions_path(@client, @project), notice: 'Ensaio excluído com sucesso!'
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
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
    } if params[:session] && params[:session][:address_id] == '0'

    params.require(:session).permit(:start_at, :finish_at, :address_id, :status, attributes)
  end
end
