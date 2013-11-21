class Article < ActiveRecord::Base

  has_many :comment_relations, as: :commentable
  has_many :comments, through: :comment_relations

  has_codebooks({
    'importance_cb' => 'importances',
    'options' => {
      'fk_cb' => 'value'
    }
  })

  acts_as_codebook({
    'key'   => 'id',
    'value' => 'title'
  })

end
