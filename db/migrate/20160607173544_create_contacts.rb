class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email, index: true
      t.string :name
      t.text :message

      t.timestamps null: false
    end
  end
end
