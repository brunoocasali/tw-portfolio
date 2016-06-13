class AddSizeToMedia < ActiveRecord::Migration
  def change
    add_column :media, :file_size, :integer
  end
end
