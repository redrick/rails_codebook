require 'factory_girl'
# Read about factories at https://github.com/thoughtbot/factory_girl

module RailsCodebook

  FactoryGirl.define do

    factory :codebook, class: RailsCodebook::Codebook do
      sequence(:value) {|n| "sth#{n}_is" }
      sequence(:name) {|n| "some.trans#{n}ation" }
      cb_name "the_same"
    end
    
    factory :cb_importance, class: RailsCodebook::Codebook do
      sequence(:value, ['low','medium','high' ].to_enum)
      sequence(:name, ['cb.low', 'cb.medium', 'cb.high'].to_enum)
      cb_name "importances"
    end
    
    factory :cb_status, class: RailsCodebook::Codebook do
      sequence(:value, ['concept', 'published', 'archived'].to_enum)
      sequence(:name, ['cb.concept', 'cb.published', 'cb.archived'].to_enum)
      cb_name "statuses"
    end

    factory :cb_type, class: RailsCodebook::Codebook do
      sequence(:value, ['home', 'work', 'public'].to_enum)
      sequence(:name, ['cb_home', 'cb_work', 'cb_public'].to_enum)
      cb_name "types"
    end



  end

end