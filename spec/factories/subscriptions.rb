# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    created_at "2014-04-08 16:34:16"
    updated_at "2014-04-08 16:34:16"
    tag_id 1
    status 1
  end
  factory :invalid_subscription do
    created_at "2014-04-08 16:34:16"
    updated_at "2014-04-08 16:34:16"
    tag_id nil
    status 1
  end
  
end
