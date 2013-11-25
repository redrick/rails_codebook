class CommentRelation < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  belongs_to :comment, dependent: :destroy

  has_codebooks({
    'type_cb' => 'polymorphic',
    'options' => {
      'type_cb' => {
        'cb_format' => 'commentable_type'
      }
    }
  })

end
