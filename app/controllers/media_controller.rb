class MediaController < ApplicationController
  before_action :set_gallery

  def index
    render json: @gallery.media
  end

  def destroy
    @medium = @gallery.media.find(params[:id])
    @medium.destroy

    render json: @medium
  end

  def create
    binding.pry
    @medium = @gallery.media.build
    @medium.filename = params[:file]
    @medium.subtitle = params[:caption]
    @medium.show = params[:show]
    @medium.save!

    render json: @medium
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end
end
