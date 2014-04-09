# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    created_at "2014-04-08 16:34:16"
    updated_at "2014-04-08 16:34:16"
    user_id 1
    tag_id 1
    status 1
  end
end
