# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    sequence(:name) { |n| "Tag#{n}" }
    num_subscribers 0

    factory :invalid_tag do
  		name "A"*31
  		num_subscribers -1
  	end

  	factory :tag_with_publications do
  		ignore do
  			publications_count 1
  		end

  		after(:create) do |tag, evaluator|
  			create_list(:publication, evaluator.publications_count, tags: [tag])
  		end
  	end
  end
  
end
