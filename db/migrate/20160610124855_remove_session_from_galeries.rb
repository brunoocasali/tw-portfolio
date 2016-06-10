class RemoveSessionFromGaleries < ActiveRecord::Migration
  def change
    remove_reference :galleries, :session, index: true, foreign_key: true
  end
end
