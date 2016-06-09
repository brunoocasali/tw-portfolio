class ChangeFieldsFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :date_at

    add_column :sessions, :start_at, :datetime
    add_column :sessions, :finish_at, :datetime
  end
end
