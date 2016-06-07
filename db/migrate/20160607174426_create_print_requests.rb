class CreatePrintRequests < ActiveRecord::Migration
  def change
    create_table :print_requests do |t|
      t.references :medium, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.integer :quantity
      t.integer :size
      t.string :size_other

      t.timestamps null: false
    end
  end
end
