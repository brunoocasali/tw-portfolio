class AddNameToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :name, :string

    remove_index :newsletters, :email
    add_index :newsletters, :email, unique: true
  end
end
