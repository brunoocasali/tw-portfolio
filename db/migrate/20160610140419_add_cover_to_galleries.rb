class AddCoverToGalleries < ActiveRecord::Migration
  def change
    add_reference :galleries, :medium, index: true, foreign_key: true
  end
end
