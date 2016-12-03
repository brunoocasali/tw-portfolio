class AddDownloadLinkToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :download_link, :string
  end
end
