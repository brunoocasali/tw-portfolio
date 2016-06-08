class AddStatusToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :status, :integer
    add_index :contacts, :status
  end
end
