class RemoveCoverFromGalleryAndAddToMedia < ActiveRecord::Migration
  def change
    remove_column :galleries, :medium_id, :integer
    remove_column :media, :show, :boolean

    add_column :media, :cover, :boolean, default: false
    add_column :media, :show, :boolean, default: false
  end
end
