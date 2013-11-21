require 'factory_girl'
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :comment do
    author "MyString"
    content "MyText"
  end
  
end
