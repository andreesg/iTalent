# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    text "My little comment"
    association :creator
    association :publication
  end

  factory :invalid_comment, parent: :comment do
    text "M"*501
    creator nil
    publication nil
  end
end
