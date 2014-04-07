# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    sequence(:name) { |n| "Tag#{n}" }
    num_subscribers 0
  end

  factory :invalid_tag, parent: :tag do
  	name "A"*31
  	num_subscribers -1
  end
end
