# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [:creator] do
  	sequence(:email) { |n| "user#{n}@italent.com" }
    password "123456789"
  end

  factory :invalid_user, parent: :user do
  	email nil
  end
end
