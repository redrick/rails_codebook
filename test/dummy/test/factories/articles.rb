require 'factory_girl'
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyString"
    text "MyText"
    author "MyString"
  end
end
