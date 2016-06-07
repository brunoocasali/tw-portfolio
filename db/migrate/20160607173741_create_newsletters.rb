class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :email, index: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
