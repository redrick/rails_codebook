# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment_relation, :class => 'CommentRelations' do
    commentable_id 1
    commentable_type "MyString"
  end
end
