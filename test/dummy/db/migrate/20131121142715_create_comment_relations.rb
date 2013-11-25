class CreateCommentRelations < ActiveRecord::Migration
  def change
    create_table :comment_relations do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :comment_id
      t.string :status_cb

      t.timestamps
    end
  end
end
