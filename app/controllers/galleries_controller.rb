class GalleriesController < ApplicationController
  before_action :set_client
  before_action :set_project
  before_action :set_gallery, only: [:edit, :update, :destroy]

  def index
    @galleries = @project.galleries.page(params[:page])
  end

  def new
    @gallery = @project.galleries.build
  end

  def edit; end

  def create
    @gallery = @project.galleries.build(gallery_params)
    @gallery.save

    respond_with(@gallery, location: edit_client_project_gallery_path(@client, @project, @gallery, next: true))
  end

  def update
    @gallery.update(gallery_params)

    respond_with(@gallery, location: client_project_galleries_path(@client, @project))
  end

  def destroy
    @gallery.destroy

    respond_with(@gallery, location: client_project_galleries_path(@client, @project))
  end

  private

  def set_client
    @client = User.client.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:project_id])
  end

  def set_gallery
    @gallery = @project.galleries.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name, :kind, :description, :show, media_attributes: [:gallery_id, :filename])
  end
end
