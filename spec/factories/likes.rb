# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :like do
    association :user
    association :publication
  end
end
