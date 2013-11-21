class Comment < ActiveRecord::Base

  belongs_to :comment_relations

  has_codebooks({
    'type_cb' => 'types',
    'options' => {
      'fk_cb' => 'value'
    }
  })


end
