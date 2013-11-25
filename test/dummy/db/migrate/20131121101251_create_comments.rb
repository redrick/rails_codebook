class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.text :content
      t.string :type_cb

      t.timestamps
    end
  end
end
