class AddStatusToPrintRequests < ActiveRecord::Migration
  def change
    add_column :print_requests, :status, :integer
    add_index :print_requests, :status
  end
end
