class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.string :author
      t.integer :importance_cb


      t.timestamps
    end
  end
end
