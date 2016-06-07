class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.references :session, index: true, foreign_key: true
      t.boolean :show
      t.text :description
      t.integer :kind

      t.timestamps null: false
    end
  end
end
