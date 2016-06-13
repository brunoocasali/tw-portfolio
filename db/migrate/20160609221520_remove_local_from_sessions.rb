class RemoveLocalFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :local
  end
end
