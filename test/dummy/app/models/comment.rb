class Comment < ActiveRecord::Base

  has_one :comment_relation, dependent: :destroy

  has_codebooks({
    'type_cb' => 'types',
    'options' => {
      'fk_cb' => 'value'
    }
  })


end
