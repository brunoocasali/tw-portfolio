class AddMessageToPrintRequests < ActiveRecord::Migration
  def change
    add_column :print_requests, :message, :text
  end
end
