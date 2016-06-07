class AddFieldsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :reference, :string
    add_column :addresses, :nick, :string
  end
end
