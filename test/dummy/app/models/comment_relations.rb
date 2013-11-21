class CommentRelations < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  has_one :comment

  has_codebooks({
    'type_cb' => 'polymorphic',
    'options' => {
      'type_cb' => {
        'cb_format' => 'commentable_type'
      }
    }
  })

end
